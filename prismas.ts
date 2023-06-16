import { Prisma } from "./src/lib/client";
import fs from 'fs';
import path from 'path';

async function main() {
  const requerimento = await Prisma.requerimento.findUnique({ where: { id: "eeb82dcf-4a54-4e03-b824-f6f14937fa06" } });

  if (!requerimento) {
    console.log('Requerimento não encontrado');
    return;
  }

  const pdfBytes = requerimento.arquivo;
  const outputDir = path.resolve('doc_out');
  fs.mkdirSync(outputDir, { recursive: true }); // Cria o diretório "doc_out" (caso não exista) de forma recursiva

  const outputPath = path.join(outputDir, 'documento.pdf');
  fs.writeFileSync(outputPath, Buffer.from(pdfBytes));
    fs.writeFileSync(outputPath, Buffer.from(pdfBytes));

  console.log('PDF salvo com sucesso');
}

main()
  .catch((error) => {
    console.error(error);
  })
  .finally(async () => {
    await Prisma.$disconnect();
  });
