import { FastifyInstance } from "fastify";
import DofController from "../controllers/dof.controller";

export async function dofRoutes(router: FastifyInstance) {
    router.get("/", DofController.getAllDOF);
    router.post("/",DofController.createNewDOF);
    router.get("/:protocolo", DofController.getDOF);
}