/*
  Warnings:

  - You are about to drop the `_NodeConnections` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `_NodeConnections` DROP FOREIGN KEY `_NodeConnections_A_fkey`;

-- DropForeignKey
ALTER TABLE `_NodeConnections` DROP FOREIGN KEY `_NodeConnections_B_fkey`;

-- DropTable
DROP TABLE `_NodeConnections`;

-- CreateTable
CREATE TABLE `NodeConnection` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `connectedToId` INTEGER NOT NULL,
    `connectedFromId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `NodeConnection` ADD CONSTRAINT `NodeConnection_connectedToId_fkey` FOREIGN KEY (`connectedToId`) REFERENCES `Node`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `NodeConnection` ADD CONSTRAINT `NodeConnection_connectedFromId_fkey` FOREIGN KEY (`connectedFromId`) REFERENCES `Node`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
