import { readFileSync } from "fs";
import { Prisma } from "./prisma";
import moment from "moment";
export default async function restore(path: string): Promise<void> {
    const data = readFileSync(path, "utf-8");
    const objects = JSON.parse(data);

    const count = 0;

    for (const obj of objects) {

        const { logradouro, bairro, uf, cep, telefone, fax, email, assunto } = obj.dados;
        const inscricao_estadual = obj.dados['inscricao-estadual'];
        const responsavel_legal = obj.dados['responsavel-legal'];
        const dateTime = moment(obj.registro, "YYYY-MM-DD HH:mm:ss").toDate();


        const Requerente = await Prisma.requerente.create({
            data: {
                empresa: obj.empresa,
                cnpj: obj.cnpj,
                inscricaoEstadual: inscricao_estadual,
                responsavelLegal: responsavel_legal,
            }
        })

        const requerimento = await Prisma.requerimento.create({
            data: {
                protocolo: obj.protocolo,
                assunto: obj.assunto || "",
                arquivo: obj.arquivo,
                status: obj.status,
                registro: dateTime,
                RequerimentoRequerente: {
                    connect: { id: Requerente.id }
                }
            }
        })
    }
}