import z from 'zod'

const foodSchema = z.object({
    name: z.string({
        invalid_type_error: 'food title must be a string',
        required_error: 'food title is required'
    }),
    title: z.string({
        invalid_type_error: 'food title must be a string',
        required_error: 'food title is required'
    }),
    price: z.number().int().min(0).max(9999),
    image: z
        .string()
        .url({
            message: 'Image must be a valid URL'
        })
        .optional(),
    type: z.array(z.enum(['cake', 'drink', 'lunch', 'coffee']), {
        required_error: 'type of food is required.',
        invalid_type_error: 'type of food must be an array of enum Genre'
    }),
    description: z.string({
        invalid_type_error: 'food description must be an string'
    })
})

export function validatePartialFood(object) {
    return foodSchema.partial().safeParse(object)
}

export function validateFood(object) {
    // eslint-disable-line space-before-function-paren
    return foodSchema.safeParse(object)
}
