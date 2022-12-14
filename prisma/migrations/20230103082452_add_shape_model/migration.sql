-- AlterTable
ALTER TABLE `NodeType` ADD COLUMN `shapeId` INTEGER NULL;

-- CreateTable
CREATE TABLE `Shape` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `NodeType` ADD CONSTRAINT `NodeType_shapeId_fkey` FOREIGN KEY (`shapeId`) REFERENCES `Shape`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
