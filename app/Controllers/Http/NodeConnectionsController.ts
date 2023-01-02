import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import {prisma} from '@ioc:Adonis/Addons/Prisma'

export default class NodeConnectionsController {

  public async show ({ params }: HttpContextContract) {
    const id = parseInt(params.id)
    console.log(id)
    return prisma.$queryRaw`
    select n.*, t.name as nodeTypeName, t.color as nodeTypeColor from Node n
    join NodeConnection c on n.id = c.connectedToId
    join NodeType t on n.typeId = t.id
    where c.connectedFromId = ${id}

    union

    select n.*, t.name as nodeTypeName, t.color as nodeTypeColor from Node n
    join NodeConnection c on n.id = c.connectedFromId
    join NodeType t on n.typeId = t.id
    where (c.connectedToId = ${id})
    `
  }

  public async store ({ request, response }: HttpContextContract) {
    const body = request.only(['from', 'to'])
    const from = parseInt(body.from)
    const to = parseInt(body.to)

    const result = await prisma.nodeConnection.findFirst({
      where: {
        OR: [
          {AND: [
            {
              connectedFromId: from,
            },
            {
              connectedToId: to
            }
          ]},
          {AND: [
            {
              connectedFromId: to,
            },
            {
              connectedToId: from
            }
          ]}

        ]
      }
    })

    if(result) {
      return response.send({message: 'Connection already exists', status: 409})
    }

    await prisma.nodeConnection.create({
      data: {
        connectedFromId: from,
        connectedToId: to
      }
    })
    return response.json({message: 'Connection created', status: 201})
  }

  public async destroy ({ params, response }: HttpContextContract) {
    const id = parseInt(params.id)
    const connections = await prisma.nodeConnection.findUnique({
      where: {
        id: id
      }
    })
    if(connections) {
      var from = connections.connectedFromId
      var to = connections.connectedToId

      const connectionsToDestroy = await prisma.nodeConnection.findMany({
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

      connectionsToDestroy.forEach(async (connection: any) => {
        await prisma.nodeConnection.delete({
          where: {
            id: connection.id
          }
        })
      })
      return response.ok('Connection deleted')
    }
    else {
      return response.badRequest('Connection does not exist')
    }
  }
}
