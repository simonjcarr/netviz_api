import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import {prisma} from '@ioc:Adonis/Addons/Prisma'


export default class TagsController {
  public async index ({ request }: HttpContextContract) {
    return prisma.tag.findMany()
  }

  public async store ({ request }: HttpContextContract) {
    const tag = await prisma.tag.create({
      data: request.only(['name']),
    })
    return tag
  }

  public async show ({ params }: HttpContextContract) {
    return prisma.tag.findUnique({
      where: {
        id: parseInt(params.id)
      }
    })
  }

  public async update ({ params, request }: HttpContextContract) {
    const tag = await prisma.tag.update({
      where: {
        id: parseInt(params.id)
      },
      data: request.only(['name']),
    })
    return tag
  }

  public async destroy ({ params }: HttpContextContract) {
    return prisma.tag.delete({
      where: {
        id: parseInt(params.id)
      }
    })
  }
}
