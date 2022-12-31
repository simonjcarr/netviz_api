import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import {prisma} from '@ioc:Adonis/Addons/Prisma'

export default class NodeConnectionsController {

  public async show ({ params }: HttpContextContract) {
    const id = parseInt(params.id)
    return prisma.$queryRaw`
    select n.*, t.name as nodeTypeName, t.color as nodeTypeColor from Node n
    join NodeConnection c on n.id = c.connectedToId
    join NodeType t on n.typeId = t.id
    where c.connectedFromId = ${id}`
  }

  public async store ({ params, response }: HttpContextContract) {
    const from = parseInt(params.from)
    const to = parseInt(params.to)

    const result = await prisma.nodeConnection.findFirst({
      where: {
        OR: [
          {
            connectedFromId: from,
            connectedToId: to
          },
          {
            connectedFromId: to,
            connectedToId: from
          }
        ]
      }
    })

    if(result) {
      return response.badRequest('Connection already exists')
    }

    await prisma.nodeConnection.create({
      data: {
        connectedFromId: from,
        connectedToId: to
      }
    })
  }

  public async destroy ({ params }: HttpContextContract) {
    const id = parseInt(params.id)
    return await prisma.nodeConnection.delete({
      where: {
        id: id
      }
    })
  }
}
