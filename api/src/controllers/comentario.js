const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

const create = async (req, res) => {
    try {
        const comentario = await prisma.comentario.create({
            data: req.body
        });
        return res.status(201).json(comentario);
    } catch (error) {
        return res.status(400).json({ message: error.message });
    }
};

const read = async (req, res) => {
    if (req.params.osId !== undefined) {
            const os = await prisma.os.findMany({
                where: {
                    id: parseInt(req.params.osId)
                },
                select: {
                    id: true,
                    descricao: true,
                    comentarios: true
                }
            });
            return res.json(os);

    } else {
        const comentarioes = await prisma.comentario.findMany();
        return res.json(comentarioes);
    }
};

const update = async (req, res) => {
    try {
        const comentario = await prisma.comentario.update({
            where: {
                id: parseInt(req.body.id)
            },
            data: req.body
        });
        return res.status(202).json(comentario);
    } catch (error) {
        return res.status(404).json({ message: "comentario não encontrada" });
    }
};

const del = async (req, res) => {
    try {
        const comentario = await prisma.comentario.delete({
            where: {
                id: parseInt(req.params.id)
            }
        });
        return res.status(204).json(comentario);
    } catch (error) {
        return res.status(404).json({ message: "comentario não encontrado" });
    }
}

module.exports = {
    create,
    read,
    update,
    del
};