import 'reflect-metadata'
import {
    Resolver,
    Query,
    Mutation,
    Arg,
    Ctx,
    FieldResolver,
    Root,
    Int,
    InputType,
    Field,
  } from 'type-graphql'
import { Context } from '../context.js'
import { Book } from './Book.js'


@InputType()
export class BookCreateInput {
  @Field()
  title: string

  @Field(type => [String])
  content: string[];

  @Field()
  isRaw: boolean;

//   @Field(type => [String])
//   prompt: string[];

//   @Field()
//   promptId: string;

//   @Field((type) => Int)
//   promptTokens: number;

//   @Field((type) => Int)
//   completionTokens: number;
  
//   @Field((type) => Int)
//   totalTokens: number;

//   @Field()
//   modelId: string;
} 


@Resolver(Book)
export class BookResolver {
    @Query((returns) => [Book])
    async feed (
        @Ctx() ctx: Context,
    ) {
        return ctx.prisma.books.findMany();
    }

@Mutation((returns) => Book)
async createBook(
    @Arg('data') data: BookCreateInput,

    @Ctx() ctx: Context,
) {
    return ctx.prisma.books.create({
        data: {
            title: data.title,
            bookEdited: {
                create: {
                    isRaw: data.isRaw,
                    content: data.content
                }
            }
        },
        include: {
            bookEdited: true,
        }
    });
}
}
