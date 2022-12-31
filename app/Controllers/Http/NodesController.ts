import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import {prisma} from '@ioc:Adonis/Addons/Prisma'

export default class NodesController {
  public async index ({ request }: HttpContextContract) {
    return prisma.node.findMany()
  }

  public async store ({ request }: HttpContextContract) {
    const data = request.only(['name', 'typeId', 'ipv4', 'hostname', 'project'])
    let tags = request.only(['tags'])
    if(tags.tags.length > 0) {
      data['tags'] = {create: []}
      tags.tags.forEach(async (tag: any) => {
        data['tags'].create.push({tag: {connect: {id: tag.id}}})
      })
    }
    console.log(data)
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
      data: request.only(['name', 'size', 'color']),
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
