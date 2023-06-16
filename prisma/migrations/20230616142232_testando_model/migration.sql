/*
  Warnings:

  - Added the required column `arquivo` to the `Requerimento` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `requerimento` ADD COLUMN `arquivo` MEDIUMBLOB NOT NULL;
