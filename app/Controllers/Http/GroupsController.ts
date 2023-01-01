import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import {prisma} from '@ioc:Adonis/Addons/Prisma'


export default class GroupsController {
  public async index ({ request }: HttpContextContract) {
    return prisma.group.findMany()
  }

  public async store ({ request }: HttpContextContract) {
    const group = await prisma.group.create({
      data: request.only(['name']),
    })
    return group
  }

  public async show ({ params }: HttpContextContract) {
    return prisma.group.findUnique({
      where: {
        id: parseInt(params.id)
      }
    })
  }

  public async update ({ params, request }: HttpContextContract) {
    const group = await prisma.group.update({
      where: {
        id: parseInt(params.id)
      },
      data: request.only(['name']),
    })
    return group
  }

  public async destroy ({ params }: HttpContextContract) {
    return prisma.group.delete({
      where: {
        id: parseInt(params.id)
      }
    })
  }
}
