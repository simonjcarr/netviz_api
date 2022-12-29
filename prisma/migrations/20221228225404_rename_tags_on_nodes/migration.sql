/*
  Warnings:

  - You are about to drop the `NodeTags` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `NodeTags` DROP FOREIGN KEY `NodeTags_nodeId_fkey`;

-- DropForeignKey
ALTER TABLE `NodeTags` DROP FOREIGN KEY `NodeTags_tagId_fkey`;

-- DropTable
DROP TABLE `NodeTags`;

-- CreateTable
CREATE TABLE `TagsOnNodes` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nodeId` INTEGER NOT NULL,
    `tagId` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `TagsOnNodes` ADD CONSTRAINT `TagsOnNodes_nodeId_fkey` FOREIGN KEY (`nodeId`) REFERENCES `Node`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `TagsOnNodes` ADD CONSTRAINT `TagsOnNodes_tagId_fkey` FOREIGN KEY (`tagId`) REFERENCES `Tag`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
