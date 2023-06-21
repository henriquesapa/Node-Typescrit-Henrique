import { Prisma } from "../lib/prisma";
import { FastifyRequest, FastifyReply } from "fastify";

class DofController{
    
    public async getAllDOF(): Promise<object> {
		const requerimentos = await Prisma.requerimento.findMany();

		return { requerimentos };
	}

    public getDOF(req: FastifyRequest, res: FastifyReply): void {
		const { protocolo } = req.params as { protocolo: string };

		Prisma.requerimento
			.findUniqueOrThrow({ where: { protocolo } })
			.then(requerimento => res.send({ requerimento }))
			.catch(err => {
				console.error(err);
				res.status(404).send({ message: "Nenhum requerimento encontrado" });
			});
	}

    public async createNewDOF(req: FastifyRequest, res: FastifyReply): Promise<void> {
		const { data } = req.body as { data: object };

		console.log(data);
		res.status(200).send(data);
	}
}

export default new DofController;