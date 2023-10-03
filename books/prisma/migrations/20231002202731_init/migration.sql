-- CreateTable
CREATE TABLE "Catalog" (
    "uuid" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "title" TEXT NOT NULL,

    CONSTRAINT "Catalog_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "Book" (
    "uuid" UUID NOT NULL,
    "isRaw" BOOLEAN NOT NULL,
    "catalogEditedId" UUID NOT NULL,
    "catalogRawId" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "content" TEXT[],
    "prompt" TEXT[],
    "characterDescriptions" TEXT[],
    "artDescriptions" TEXT[],
    "promptId" VARCHAR(50) NOT NULL,
    "promptTokens" INTEGER NOT NULL,
    "completionTokens" INTEGER NOT NULL,
    "totalTokens" INTEGER NOT NULL,
    "modelId" VARCHAR(50) NOT NULL,

    CONSTRAINT "Book_pkey" PRIMARY KEY ("uuid")
);

-- CreateIndex
CREATE UNIQUE INDEX "Book_catalogEditedId_key" ON "Book"("catalogEditedId");

-- CreateIndex
CREATE UNIQUE INDEX "Book_catalogRawId_key" ON "Book"("catalogRawId");

-- AddForeignKey
ALTER TABLE "Book" ADD CONSTRAINT "Book_catalogEditedId_fkey" FOREIGN KEY ("catalogEditedId") REFERENCES "Catalog"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Book" ADD CONSTRAINT "Book_catalogRawId_fkey" FOREIGN KEY ("catalogRawId") REFERENCES "Catalog"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;
