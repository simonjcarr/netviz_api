import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import {prisma} from '@ioc:Adonis/Addons/Prisma'

export default class NodesController {
  public async index ({ request }: HttpContextContract) {
    const nodeIdFilter: number = parseInt(request.qs().nodeIdFilter) || 0

    if (nodeIdFilter == 0) {
    return prisma.node.findMany({include: {
      tags: {
        include: {

          tag: true
        }
      },
      type: true,
      connectedFrom: {
        include: {
          connectedTo: true
        }
      }
    }})
  } else {
    return prisma.node.findMany({
      where: {
        OR: [
          {
            id: nodeIdFilter
          },
          {connectedFrom: {
            some: {
              connectedToId: nodeIdFilter
            }
          }},
          {
            connectedTo: {
              some: {
                connectedFromId: nodeIdFilter
              }
            }
          }
        ]
      },
      include: {
      tags: {
        include: {

          tag: true
        }
      },
      type: true,
      connectedFrom: {
        include: {
          connectedTo: true
        }
      },
    }})
  }
  }

  public async store ({ request }: HttpContextContract) {
    const data = request.only(['label', 'typeId', 'ipv4', 'hostname', 'project', 'groupId'])
    let tags = request.only(['tags'])
    if(tags.tags.length > 0) {
      data['tags'] = {create: []}
      tags.tags.forEach(async (tag: any) => {
        data['tags'].create.push({tag: {connect: {id: tag.id}}})
      })
    }
    const node = await prisma.node.create({
      data: data
    })
    return node
  }

  public async show ({ params }: HttpContextContract) {
    return prisma.node.findUnique({
      where: {
        id: parseInt(params.id)
      },
      include: {
        tags: {
          include: {
            tag: true
          }
        },
        type: true,
        group: true,
        connectedFrom: {
          include: {
            connectedTo: true
          }
        }
      }
    })
  }

  public async update ({ params, request }: HttpContextContract) {
    const type = await prisma.node.update({
      where: {
        id: parseInt(params.id)
      },
      data: request.only(['label', 'size', 'color']),
    })
    return type
  }

  public async destroy ({ params }: HttpContextContract) {
    return prisma.node.delete({
      where: {
        id: parseInt(params.id)
      }
    })
  }

}
