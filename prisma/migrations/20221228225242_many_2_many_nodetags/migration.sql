/*
  Warnings:

  - You are about to drop the column `tagId` on the `Node` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE `Node` DROP FOREIGN KEY `Node_tagId_fkey`;

-- AlterTable
ALTER TABLE `Node` DROP COLUMN `tagId`;

-- CreateTable
CREATE TABLE `NodeTags` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nodeId` INTEGER NOT NULL,
    `tagId` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `NodeTags` ADD CONSTRAINT `NodeTags_nodeId_fkey` FOREIGN KEY (`nodeId`) REFERENCES `Node`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `NodeTags` ADD CONSTRAINT `NodeTags_tagId_fkey` FOREIGN KEY (`tagId`) REFERENCES `Tag`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
