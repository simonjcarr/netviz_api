import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import {prisma} from '@ioc:Adonis/Addons/Prisma'


export default class NodeTypeController {
  public async index ({ request }: HttpContextContract) {
    return prisma.nodeType.findMany()
  }

  public async store ({ request }: HttpContextContract) {
    const type = await prisma.nodeType.create({
      data: request.only(['name', 'size', 'color']),
    })
    return type
  }

  public async show ({ params }: HttpContextContract) {
    return prisma.nodeType.findUnique({
      where: {
        id: parseInt(params.id)
      }
    })
  }

  public async update ({ params, request }: HttpContextContract) {
    const type = await prisma.nodeType.update({
      where: {
        id: parseInt(params.id)
      },
      data: request.only(['name', 'size', 'color']),
    })
    return type
  }

  public async destroy ({ params }: HttpContextContract) {
    return prisma.nodeType.delete({
      where: {
        id: parseInt(params.id)
      }
    })
  }
}
