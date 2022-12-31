/*
  Warnings:

  - You are about to drop the `Connections` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `Connections` DROP FOREIGN KEY `Connections_connectedFromId_fkey`;

-- DropForeignKey
ALTER TABLE `Connections` DROP FOREIGN KEY `Connections_connectedToId_fkey`;

-- DropTable
DROP TABLE `Connections`;

-- CreateTable
CREATE TABLE `_connectedFrom` (
    `A` INTEGER NOT NULL,
    `B` INTEGER NOT NULL,

    UNIQUE INDEX `_connectedFrom_AB_unique`(`A`, `B`),
    INDEX `_connectedFrom_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `_connectedFrom` ADD CONSTRAINT `_connectedFrom_A_fkey` FOREIGN KEY (`A`) REFERENCES `Node`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_connectedFrom` ADD CONSTRAINT `_connectedFrom_B_fkey` FOREIGN KEY (`B`) REFERENCES `Node`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
