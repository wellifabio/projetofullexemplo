const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

const colaboradores = require("./seed/colaboradores.json");
const oss = require("./seed/oss.json");
const comentarios = require("./seed/comentarios.json");

async function main() {
    for (const colaborador of colaboradores) {
        await prisma.colaborador.create({
            data: colaborador
        });
    }
    for (const os of oss) {
        await prisma.os.create({
            data: os
        });
    }
    for (const comentario of comentarios) {
        await prisma.comentario.create({
            data: comentario
        });
    }
}

main()
    .then(async () => {
        await prisma.$disconnect()
        console.log('Seed complete');
    })
    .catch(async (e) => {
        console.error(e)
        await prisma.$disconnect()
        process.exit(1)
    });