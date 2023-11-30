import { Router } from 'express'

import { foodController } from '../controllers/foodct.js'

export const foodRouter = Router()

foodRouter.get('/', foodController.getAll)
foodRouter.post('/', foodController.create)
foodRouter.get('/:id', foodController.getById)
foodRouter.patch('/:id', foodController.update)
foodRouter.delete('/:id', foodController.delete)
