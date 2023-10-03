/*
  Warnings:

  - You are about to drop the column `catalogEditedId` on the `Book` table. All the data in the column will be lost.
  - You are about to drop the column `catalogRawId` on the `Book` table. All the data in the column will be lost.
  - You are about to drop the `Catalog` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[libraryEditedId]` on the table `Book` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[libraryRawId]` on the table `Book` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `libraryEditedId` to the `Book` table without a default value. This is not possible if the table is not empty.
  - Added the required column `libraryRawId` to the `Book` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Book" DROP CONSTRAINT "Book_catalogEditedId_fkey";

-- DropForeignKey
ALTER TABLE "Book" DROP CONSTRAINT "Book_catalogRawId_fkey";

-- DropIndex
DROP INDEX "Book_catalogEditedId_key";

-- DropIndex
DROP INDEX "Book_catalogRawId_key";

-- AlterTable
ALTER TABLE "Book" DROP COLUMN "catalogEditedId",
DROP COLUMN "catalogRawId",
ADD COLUMN     "libraryEditedId" UUID NOT NULL,
ADD COLUMN     "libraryRawId" UUID NOT NULL;

-- DropTable
DROP TABLE "Catalog";

-- CreateTable
CREATE TABLE "Library" (
    "uuid" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "title" TEXT NOT NULL,

    CONSTRAINT "Library_pkey" PRIMARY KEY ("uuid")
);

-- CreateIndex
CREATE UNIQUE INDEX "Book_libraryEditedId_key" ON "Book"("libraryEditedId");

-- CreateIndex
CREATE UNIQUE INDEX "Book_libraryRawId_key" ON "Book"("libraryRawId");

-- AddForeignKey
ALTER TABLE "Book" ADD CONSTRAINT "Book_libraryEditedId_fkey" FOREIGN KEY ("libraryEditedId") REFERENCES "Library"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Book" ADD CONSTRAINT "Book_libraryRawId_fkey" FOREIGN KEY ("libraryRawId") REFERENCES "Library"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;
