-- CreateTable
CREATE TABLE "Requerimento" (
    "id" TEXT NOT NULL,
    "protocolo" TEXT NOT NULL,
    "assunto" TEXT NOT NULL,
    "arquivo" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "registro" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Requerimento_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RequerimentoRequerente" (
    "id" TEXT NOT NULL,
    "requerimentoId" TEXT NOT NULL,
    "requerenteId" TEXT NOT NULL,

    CONSTRAINT "RequerimentoRequerente_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Requerente" (
    "id" TEXT NOT NULL,
    "empresa" TEXT NOT NULL,
    "cnpj" TEXT NOT NULL,
    "inscricaoEstadual" TEXT NOT NULL,
    "responsavelLegal" TEXT NOT NULL,

    CONSTRAINT "Requerente_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Endereco" (
    "id" TEXT NOT NULL,
    "cep" TEXT NOT NULL,
    "logradouro" TEXT NOT NULL,
    "bairro" TEXT NOT NULL,
    "municipio" TEXT NOT NULL,
    "uf" TEXT NOT NULL,
    "requerenteId" TEXT NOT NULL,

    CONSTRAINT "Endereco_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Contato" (
    "id" TEXT NOT NULL,
    "telefone" TEXT,
    "fax" TEXT,
    "email" TEXT,
    "requerenteId" TEXT NOT NULL,

    CONSTRAINT "Contato_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Requerimento_protocolo_key" ON "Requerimento"("protocolo");

-- CreateIndex
CREATE UNIQUE INDEX "RequerimentoRequerente_requerimentoId_key" ON "RequerimentoRequerente"("requerimentoId");

-- CreateIndex
CREATE UNIQUE INDEX "RequerimentoRequerente_requerenteId_key" ON "RequerimentoRequerente"("requerenteId");

-- CreateIndex
CREATE UNIQUE INDEX "Requerente_cnpj_key" ON "Requerente"("cnpj");

-- CreateIndex
CREATE UNIQUE INDEX "Endereco_requerenteId_key" ON "Endereco"("requerenteId");

-- CreateIndex
CREATE UNIQUE INDEX "Contato_requerenteId_key" ON "Contato"("requerenteId");

-- AddForeignKey
ALTER TABLE "RequerimentoRequerente" ADD CONSTRAINT "RequerimentoRequerente_requerenteId_fkey" FOREIGN KEY ("requerenteId") REFERENCES "Requerente"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RequerimentoRequerente" ADD CONSTRAINT "RequerimentoRequerente_requerimentoId_fkey" FOREIGN KEY ("requerimentoId") REFERENCES "Requerimento"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Endereco" ADD CONSTRAINT "Endereco_requerenteId_fkey" FOREIGN KEY ("requerenteId") REFERENCES "Requerente"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Contato" ADD CONSTRAINT "Contato_requerenteId_fkey" FOREIGN KEY ("requerenteId") REFERENCES "Requerente"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
