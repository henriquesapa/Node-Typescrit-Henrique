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


        const requerimento = await Prisma.requerimento.create({
            data: {
                protocolo: obj.protocolo,
                assunto: obj.assunto || "",
                arquivo: obj.arquivo,
                status: obj.status,
                registro: dateTime,
            },
        });


        const requerente = await Prisma.requerente.create({
            data: {
                empresa: obj.empresa,
                cnpj: obj.cnpj.replace(/\D/g, "").substring(0, 14),// Remove todos os caracteres não numéricos do CNPJ,
                inscricaoEstadual: inscricao_estadual.replace(/\D/g, ""),
                responsavelLegal: responsavel_legal.toUpperCase(),
                RequerimentoRequerente: {
                    create: {
                        requerimento: { connect: { id: requerimento.id } },
                    },
                },
            },
        });

        let endereco = await Prisma.endereco.findFirst({
            where: {
                cep: cep.replace(/\D/g, "").substring(0, 7),
                logradouro: logradouro.toUpperCase(),
                bairro: bairro.toUpperCase(),
                municipio: obj.municipio.toUpperCase(),
                uf: uf.substring(0, 2).toUpperCase(),
            }
        })
        if (!endereco) {
            const endereco = await Prisma.endereco.create({
                data: {
                    cep: cep.replace(/\D/g, "").substring(0, 7),
                    logradouro: logradouro.toUpperCase(),
                    bairro: bairro.toUpperCase(),
                    municipio: obj.municipio.toUpperCase(),
                    uf: uf.substring(0, 2).toUpperCase(),
                    requerente: { connect: { id: requerente.id } },
                },
            });
        }
        let contato = await Prisma.contato.findFirst({
            where: {
                email,
                telefone: telefone.replace(/\D/g, ""),
                fax: fax.replace(/\D/g, "")
            }
        })

        if (!contato) {
            contato = await Prisma.contato.create({
                data: {
                    telefone: telefone.replace(/\D/g, ""),
                    fax: fax.replace(/\D/g, ""),
                    email: email,
                    requerente: { connect: { id: requerente.id } },
                },
            });
        }

        console.log(obj)
    }

}
