import "dotenv/config";

import fastify from "fastify";
import cors from "@fastify/cors";

import { dofRoutes } from "./routes/dof.routes";
import restore from "./lib/restoreDump";
import { Prisma } from "./lib/prisma";

class Application {
    private app = fastify();
    private port = process.env.PORT ? parseInt(process.env.PORT) : 9000;

    constructor() {
        this.app.register(cors, { origin: true });
    }

    private buildRoutes(): Promise<void> {
        return new Promise((resolve, reject) => {
            try {
                this.app.register(dofRoutes, { prefix: "/dof" });

                resolve();
            } catch (error) {
                reject(error);
            }
        });
    }

    private listen(): Promise<void> {
        return new Promise((resolve, reject) => {
            try {
                this.app
                    .listen({ port: this.port, host: "0.0.0.0" })
                    .then(() =>
                        console.log(`🐵 servidor HTTP em execução http://localhost:${this.port}/ 🐸`),
                    );

                resolve();
            } catch (err) {
                console.error(err);
                reject(err);
            }
        });
    }

    public async importDataFromDump(): Promise<void> {
        await Prisma.requerimentoRequerente.deleteMany();
        await Prisma.requerimento.deleteMany();
        await Prisma.contato.deleteMany();
        await Prisma.endereco.deleteMany();
        await Prisma.requerente.deleteMany();

        restore(__dirname + "/json/dados.json");
    }

    public async load(): Promise<void> {
        await this.buildRoutes();
        await this.listen();
        await this.importDataFromDump();
    }
}
const App = new Application();

App.load();

export { App };