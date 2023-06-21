-- CreateTable
CREATE TABLE "Requerimento" (
    "id" TEXT NOT NULL,
    "protocolo" TEXT NOT NULL,
    "empresa" TEXT NOT NULL,
    "cnpj" TEXT NOT NULL,
    "inscricaoEstadual" TEXT,
    "assunto" TEXT NOT NULL,
    "arquivo" BYTEA NOT NULL,
    "status" TEXT NOT NULL,
    "registro" TIMESTAMP(3) NOT NULL,
    "requerenteId" TEXT NOT NULL,

    CONSTRAINT "Requerimento_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Requerente" (
    "id" TEXT NOT NULL,
    "empresa" TEXT NOT NULL,
    "cpfCnpj" TEXT NOT NULL,
    "inscricaoEstadual" TEXT,
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
CREATE UNIQUE INDEX "Endereco_requerenteId_key" ON "Endereco"("requerenteId");

-- CreateIndex
CREATE UNIQUE INDEX "Contato_requerenteId_key" ON "Contato"("requerenteId");

-- AddForeignKey
ALTER TABLE "Requerimento" ADD CONSTRAINT "Requerimento_requerenteId_fkey" FOREIGN KEY ("requerenteId") REFERENCES "Requerente"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Endereco" ADD CONSTRAINT "Endereco_requerenteId_fkey" FOREIGN KEY ("requerenteId") REFERENCES "Requerente"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Contato" ADD CONSTRAINT "Contato_requerenteId_fkey" FOREIGN KEY ("requerenteId") REFERENCES "Requerente"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
