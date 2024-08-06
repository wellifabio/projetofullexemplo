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
    if (req.params.matricula !== undefined) {
        if (req.body.setor == undefined) {
            const os = await prisma.os.findMany({
                where: {
                    matricula: req.params.matricula
                }
            });
        } else {
            if (req.body.setor == "Manutenção") {
                const os = await prisma.os.findMany({
                    where: {
                        encerramento: null,
                    }
                });
            }
        }
        return res.json(os);
    } else {
        const oses = await prisma.os.findMany();
        return res.json(oses);
    }
};

const update = async (req, res) => {
    try {
        const os = await prisma.os.update({
            where: {
                id: parseInt(req.params.id)
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
    update,
    del
};