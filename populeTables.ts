import { PrismaClient } from '@prisma/client';
import * as fs from 'fs';

const prisma = new PrismaClient();

async function populateTables() {
  try {
    const jsonData = fs.readFileSync('src/json/dados.json', 'utf8');
    const jsonDataParsed = JSON.parse(jsonData);

    for (const data of jsonDataParsed) {
      const { dados, ...requerimentoData } = data;

      console.log(data.municipio)
      
      const enderecoData = {
        cep: dados.cep,
        logradouro: dados.logradouro,
        bairro: dados.bairro,
        municipio: data['municipio'], // Corrigido aqui
        uf: dados.uf,
      };

      const contatoData = {
        telefone: dados.telefone,
        fax: dados.fax,
        email: dados.email,
      };

      const requerenteData = {
        empresa: data.empresa,
        cpfCnpj: data.cnpj,
        inscricaoEstadual: dados['inscricao-estadual'],
        responsavelLegal: dados['responsavel-legal'],
        enderecoId: { create: enderecoData },
        contatoId: { create: contatoData },
      };

      const requerimento = await prisma.requerimento.create({
        data: {
          ...requerimentoData,
          arquivo: Buffer.from(data.arquivo),
          status: data.status,
          registro: new Date(data.registro),
          requerente: {
            create: {
              ...requerenteData,
              assunto: dados.assunto, // Corrigido aqui
            },
          },
        },
      });

      console.log('Requerimento criado:', requerimento);
    }

    console.log('Dados do JSON foram armazenados nas tabelas com sucesso.');
  } catch (error) {
    console.error('Ocorreu um erro ao armazenar os dados:', error);
  } finally {
    await prisma.$disconnect();
  }
}

populateTables();
