/*
  Warnings:

  - You are about to drop the column `nome_razaosocial` on the `requerimento` table. All the data in the column will be lost.
  - Added the required column `nome_razao_social` to the `Requerimento` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `requerimento` DROP COLUMN `nome_razaosocial`,
    ADD COLUMN `nome_razao_social` VARCHAR(191) NOT NULL;
