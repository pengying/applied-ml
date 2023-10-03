import 'reflect-metadata'
import { ObjectType, Field, ID, Int } from 'type-graphql'

@ObjectType()
export class Book {
    @Field(type => ID)
    uuid: string;

    @Field()
    isRaw: boolean;

    @Field()
    createdAt: Date;
  
    @Field()
    updatedAt: Date;

    @Field(type => [String])
    content: string[];

    // @Field(type => [String])
    // prompt: string[];

    // @Field(type => [String])
    // characterDescriptions: string[];

    // @Field(type => [String])
    // artDescriptions: string[];

    // @Field()
    // promptId: string;

    // @Field((type) => Int)
    // promptTokens: number;

    // @Field((type) => Int)
    // completionTokens: number;

    // @Field((type) => Int)
    // totalTokens: number;
    
    // @Field()
    // modelId: string;
}