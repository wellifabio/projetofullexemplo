const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

const create = async (req, res) => {
    try {
        const os = await prisma.os.create({
            data: req.body
        });
        return res.status(201).json(os);
    } catch (error) {
        return res.status(400).json({ message: error.message });
    }
};

const read = async (req, res) => {
    if (req.params.id !== undefined) {
        const os = await prisma.os.findUnique({
            where: {
                id: parseInt(req.params.id)
            },
            select: {
                id: true,
                descricao: true,
                colaborador: true,
                executor: true,
                abertura: true,
                encerramento: true,
                comentarios: true,
                latitude: true,
                longitude: true
            }
        });
        return res.json(os);
    } else {
        const oses = await prisma.os.findMany(
            {
                orderBy: {
                    id: 'desc'
                }
            }
        );
        return res.json(oses);
    }
};

const readByColaborador = async (req, res) => {
    const os = await prisma.os.findMany({
        where: {
            colaborador: req.params.matricula
        },
        orderBy: {
            id: 'desc'
        }
    });
    return res.json(os);
};

const readByExecutor = async (req, res) => {
    const os = await prisma.os.findMany({
        where: {
            executor: req.params.matricula
        },
        orderBy: {
            id: 'desc'
        }
    });
    return res.json(os);
}

const readAbertas = async (req, res) => {
    const os = await prisma.os.findMany({
        where: {
            encerramento: null
        },
        orderBy: {
            id: 'desc'
        }
    });
    return res.json(os);
}

const readFechadas = async (req, res) => {
    const os = await prisma.os.findMany({
        where: {
            encerramento: { not: null }
        },
        orderBy: {
            id: 'desc'
        }
    });
    return res.json(os);
}

const update = async (req, res) => {
    try {
        const os = await prisma.os.update({
            where: {
                id: parseInt(req.body.id)
            },
            data: req.body
        });
        return res.status(202).json(os);
    } catch (error) {
        return res.status(404).json({ message: "os não encontrada" });
    }
};

const del = async (req, res) => {
    try {
        const os = await prisma.os.delete({
            where: {
                id: parseInt(req.params.id)
            }
        });
        return res.status(204).json(os);
    } catch (error) {
        return res.status(404).json({ message: "os não encontrado" });
    }
}

module.exports = {
    create,
    read,
    readByColaborador,
    readByExecutor,
    readAbertas,
    readFechadas,
    update,
    del
};