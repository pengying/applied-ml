/*
  Warnings:

  - You are about to drop the `Book` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Library` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Book" DROP CONSTRAINT "Book_libraryEditedId_fkey";

-- DropForeignKey
ALTER TABLE "Book" DROP CONSTRAINT "Book_libraryRawId_fkey";

-- DropTable
DROP TABLE "Book";

-- DropTable
DROP TABLE "Library";

-- CreateTable
CREATE TABLE "Books" (
    "uuid" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "title" TEXT NOT NULL,

    CONSTRAINT "Books_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "BookRevisions" (
    "uuid" UUID NOT NULL,
    "isRaw" BOOLEAN NOT NULL,
    "bookRawId" UUID NOT NULL,
    "bookEditedId" UUID,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "content" TEXT[],

    CONSTRAINT "BookRevisions_pkey" PRIMARY KEY ("uuid")
);

-- CreateIndex
CREATE UNIQUE INDEX "BookRevisions_bookRawId_key" ON "BookRevisions"("bookRawId");

-- CreateIndex
CREATE UNIQUE INDEX "BookRevisions_bookEditedId_key" ON "BookRevisions"("bookEditedId");

-- AddForeignKey
ALTER TABLE "BookRevisions" ADD CONSTRAINT "BookRevisions_bookRawId_fkey" FOREIGN KEY ("bookRawId") REFERENCES "Books"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BookRevisions" ADD CONSTRAINT "BookRevisions_bookEditedId_fkey" FOREIGN KEY ("bookEditedId") REFERENCES "Books"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;
