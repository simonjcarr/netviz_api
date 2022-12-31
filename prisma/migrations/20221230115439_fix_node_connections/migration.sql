/*
  Warnings:

  - You are about to drop the `_nodeConnection` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `_nodeConnection` DROP FOREIGN KEY `_nodeConnection_A_fkey`;

-- DropForeignKey
ALTER TABLE `_nodeConnection` DROP FOREIGN KEY `_nodeConnection_B_fkey`;

-- DropTable
DROP TABLE `_nodeConnection`;

-- CreateTable
CREATE TABLE `NodeConnections` (
    `connectionsFromId` INTEGER NOT NULL,
    `connectionsToId` INTEGER NOT NULL,

    PRIMARY KEY (`connectionsFromId`, `connectionsToId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `NodeConnections` ADD CONSTRAINT `NodeConnections_connectionsFromId_fkey` FOREIGN KEY (`connectionsFromId`) REFERENCES `Node`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `NodeConnections` ADD CONSTRAINT `NodeConnections_connectionsToId_fkey` FOREIGN KEY (`connectionsToId`) REFERENCES `Node`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
