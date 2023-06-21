/*
  Warnings:

  - You are about to drop the column `cpfCnpj` on the `Requerente` table. All the data in the column will be lost.
  - You are about to drop the column `cnpj` on the `Requerimento` table. All the data in the column will be lost.
  - You are about to drop the column `empresa` on the `Requerimento` table. All the data in the column will be lost.
  - You are about to drop the column `inscricaoEstadual` on the `Requerimento` table. All the data in the column will be lost.
  - You are about to drop the column `requerenteId` on the `Requerimento` table. All the data in the column will be lost.
  - Added the required column `cnpj` to the `Requerente` table without a default value. This is not possible if the table is not empty.
  - Made the column `inscricaoEstadual` on table `Requerente` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "Requerimento" DROP CONSTRAINT "Requerimento_requerenteId_fkey";

-- AlterTable
ALTER TABLE "Requerente" DROP COLUMN "cpfCnpj",
ADD COLUMN     "cnpj" TEXT NOT NULL,
ALTER COLUMN "inscricaoEstadual" SET NOT NULL;

-- AlterTable
ALTER TABLE "Requerimento" DROP COLUMN "cnpj",
DROP COLUMN "empresa",
DROP COLUMN "inscricaoEstadual",
DROP COLUMN "requerenteId";

-- CreateTable
CREATE TABLE "RequerimentoRequerente" (
    "id" TEXT NOT NULL,
    "requerimentoId" TEXT NOT NULL,
    "requerenteId" TEXT NOT NULL,

    CONSTRAINT "RequerimentoRequerente_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "RequerimentoRequerente_requerimentoId_key" ON "RequerimentoRequerente"("requerimentoId");

-- CreateIndex
CREATE UNIQUE INDEX "RequerimentoRequerente_requerenteId_key" ON "RequerimentoRequerente"("requerenteId");

-- AddForeignKey
ALTER TABLE "RequerimentoRequerente" ADD CONSTRAINT "RequerimentoRequerente_requerenteId_fkey" FOREIGN KEY ("requerenteId") REFERENCES "Requerente"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RequerimentoRequerente" ADD CONSTRAINT "RequerimentoRequerente_requerimentoId_fkey" FOREIGN KEY ("requerimentoId") REFERENCES "Requerimento"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
