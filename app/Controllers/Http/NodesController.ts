import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import {prisma} from '@ioc:Adonis/Addons/Prisma'

export default class NodesController {
  public async index ({ request }: HttpContextContract) {
    return prisma.node.findMany()
  }

  public async store ({ request }: HttpContextContract) {
    const node = await prisma.node.create({
      data: request.only(['name', 'typeId', 'ipv4', 'hostname', 'project']),
    })
    return node
  }

  public async show ({ params }: HttpContextContract) {
    return prisma.node.findUnique({
      where: {
        id: parseInt(params.id)
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
