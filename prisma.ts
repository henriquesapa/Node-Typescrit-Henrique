import { Prisma } from "./src/lib/client";
import fs from 'fs';
import { PDFDocument } from 'pdf-lib';

async function main(): Promise<void> {
  
  const filePath = 'doc/guia_pescador.pdf';
  const pdfBuffer = fs.readFileSync(filePath);
 

  const Requerimento = await Prisma.requerimento.create({
    data: {
      nome_razao_social: 'Teste',
      cpf_cnpj: '123123123',
      inscricao:'321321321',
      arquivo: pdfBuffer
    },
  })
  console.log(Requerimento)
}

main()
  .then(async () => {
    await Prisma.$disconnect()
  })
  .catch(async (e) => {
    console.error(e)
    await Prisma.$disconnect()
    process.exit(1)
  })