import "reflect-metadata";

import path from "node:path";
import { fileURLToPath } from 'url';

import { BookResolver } from './classes/BookResolver.js';

import { ApolloServer } from "@apollo/server";
import { startStandaloneServer } from "@apollo/server/standalone";

import { buildSchema } from "type-graphql";
import { PrismaClient } from "@prisma/client";


const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const prisma = new PrismaClient();


const schema = await buildSchema({
    resolvers: [BookResolver],
    emitSchemaFile: path.resolve(__dirname, "schema.graphql"),
  });

// // A schema is a collection of type definitions (hence "typeDefs")
// // that together define the "shape" of queries that are executed against
// // your data.
// const typeDefs = `#graphql
//   # Comments in GraphQL strings (such as this one) start with the hash (#) symbol.

//   # This "Book" type defines the queryable fields for every book in our data source.
//   type Library {
//     """
//     Id of catalog row
//     """
//     uuid: String
//     createdAt: DateTime
//     updatedAt: DateTime
//     title: String
//     bookEdited: Book
//     bookRaw: Book
//   }

//   type Book {
//     uuid: String
//     isRaw: Boolean
//     createdAt: DateTime
//     updatedAt: DateTime
//     content: [String]
//     prompt: [String]
//     characterDescriptions: [String]
//     artDescriptions: [String]
//     promptId: String
//     promptTokens: Int
//     completionTokens: Int
//     totalTokens: Int
//     modelId: String
//   }

//   # The "Query" type is special: it lists all of the available queries that
//   # clients can execute, along with the return type for each. In this
//   # case, the "books" query returns an array of zero or more Books (defined above).
//   type Query {
//     books: [Book]
//     library: [Library]
//   }

//   type Mutation {
//     addBookRaw(content: BookRaw): Library
//   }

//   input BookRaw {
//     title: String, 
//     content: [String], 
//     prompt: [String], 
//     characterDescriptions: [String],
//     artDescriptions: [String],
//     promptId: String,
//     promptTokens: Int,
//     completionTokens: Int,
//     totalTokens: Int,
//     modelId: String
//   }
// `;


// Resolvers define how to fetch the types defined in your schema.
// This resolver retrieves books from the "books" array above.
// const resolvers = {
//   Query: {
//     books: () => {
//         return prisma.books.findMany();
//     },
//     library: () => {
//         return prisma.bookRevisions.findMany();
//     },
//   },
// };

// The ApolloServer constructor requires two parameters: your schema
// definition and your set of resolvers.
const server = new ApolloServer({
  schema
});

// Passing an ApolloServer instance to the `startStandaloneServer` function:
//  1. creates an Express app
//  2. installs your ApolloServer instance as middleware
//  3. prepares your app to handle incoming requests
const { url } = await startStandaloneServer(server, {
  listen: { port: 4000 },
});

console.log(`🚀  Server ready at: ${url}`);
