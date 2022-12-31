/*
  Warnings:

  - You are about to drop the column `connectedToId` on the `Node` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE `Node` DROP FOREIGN KEY `Node_connectedToId_fkey`;

-- AlterTable
ALTER TABLE `Node` DROP COLUMN `connectedToId`;

-- CreateTable
CREATE TABLE `NodeConnections` (
    `nodeId` INTEGER NOT NULL,
    `targetId` INTEGER NOT NULL,

    PRIMARY KEY (`nodeId`, `targetId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `NodeConnections` ADD CONSTRAINT `NodeConnections_nodeId_fkey` FOREIGN KEY (`nodeId`) REFERENCES `Node`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `NodeConnections` ADD CONSTRAINT `NodeConnections_targetId_fkey` FOREIGN KEY (`targetId`) REFERENCES `Node`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
