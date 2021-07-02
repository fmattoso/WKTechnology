-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema WKTeste
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `WKTeste` ;

-- -----------------------------------------------------
-- Schema WKTeste
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `WKTeste` DEFAULT CHARACTER SET utf8 ;
USE `WKTeste` ;

-- -----------------------------------------------------
-- Table `WKTeste`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WKTeste`.`clientes` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `cidade` VARCHAR(100) NULL,
  `uf` VARCHAR(2) NULL,
  PRIMARY KEY (`codigo`),
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WKTeste`.`produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WKTeste`.`produtos` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(100) NOT NULL,
  `precoVenda` DECIMAL(13,2) NOT NULL DEFAULT 0,
  PRIMARY KEY (`codigo`),
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WKTeste`.`pedidosDadosGerais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WKTeste`.`pedidosDadosGerais` (
  `numeroPedido` INT NOT NULL AUTO_INCREMENT,
  `dataEmissao` DATETIME NULL,
  `valorTotal` DECIMAL(13,2) NULL,
  `codigoCliente` INT NOT NULL,
  PRIMARY KEY (`numeroPedido`),
  UNIQUE INDEX `numeroPedido_UNIQUE` (`numeroPedido` ASC) ,
  INDEX `fk_pedidosDadosGerais_clientes_idx` (`codigoCliente` ASC) ,
  CONSTRAINT `fk_pedidosDadosGerais_clientes`
    FOREIGN KEY (`codigoCliente`)
    REFERENCES `WKTeste`.`clientes` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WKTeste`.`pedidosProdutos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WKTeste`.`pedidosProdutos` (
  `idPedidosProdutos` INT NOT NULL AUTO_INCREMENT,
  `quantidade` DECIMAL(13,3) NOT NULL DEFAULT 1,
  `valorUnitario` DECIMAL(13,2) NOT NULL,
  `valorTotal` DECIMAL(13,2) NULL,
  `numeroPedido` INT NOT NULL,
  `codigoProduto` INT NOT NULL,
  PRIMARY KEY (`idPedidosProdutos`),
  UNIQUE INDEX `idPedidosProdutos_UNIQUE` (`idPedidosProdutos` ASC) ,
  INDEX `fk_pedidosProdutos_pedidosDadosGerais1_idx` (`numeroPedido` ASC) ,
  INDEX `fk_pedidosProdutos_produtos1_idx` (`codigoProduto` ASC) ,
  CONSTRAINT `fk_pedidosProdutos_pedidosDadosGerais1`
    FOREIGN KEY (`numeroPedido`)
    REFERENCES `WKTeste`.`pedidosDadosGerais` (`numeroPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidosProdutos_produtos1`
    FOREIGN KEY (`codigoProduto`)
    REFERENCES `WKTeste`.`produtos` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `WKTeste`.`clientes`
-- -----------------------------------------------------
START TRANSACTION;
USE `WKTeste`;
INSERT INTO `WKTeste`.`clientes` (`codigo`, `nome`, `cidade`, `uf`) VALUES (1, 'Cliente #1', 'Curitiba', 'PR');
INSERT INTO `WKTeste`.`clientes` (`codigo`, `nome`, `cidade`, `uf`) VALUES (2, 'Cliente #2', 'Joinville', 'SC');
INSERT INTO `WKTeste`.`clientes` (`codigo`, `nome`, `cidade`, `uf`) VALUES (3, 'Cliente #3', 'Palhoça', 'SC');
INSERT INTO `WKTeste`.`clientes` (`codigo`, `nome`, `cidade`, `uf`) VALUES (4, 'Cliente #4', 'São José', 'SC');
INSERT INTO `WKTeste`.`clientes` (`codigo`, `nome`, `cidade`, `uf`) VALUES (5, 'Cliente #5', 'Pelotas', 'RS');
INSERT INTO `WKTeste`.`clientes` (`codigo`, `nome`, `cidade`, `uf`) VALUES (6, 'Cliente #6', 'São Paulo', 'SP');
INSERT INTO `WKTeste`.`clientes` (`codigo`, `nome`, `cidade`, `uf`) VALUES (7, 'Cliente #7', 'Londrina', 'PR');
INSERT INTO `WKTeste`.`clientes` (`codigo`, `nome`, `cidade`, `uf`) VALUES (8, 'Cliente #8', 'Foz do Iguaçu', 'PR');
INSERT INTO `WKTeste`.`clientes` (`codigo`, `nome`, `cidade`, `uf`) VALUES (9, 'Cliente #9', 'Porto Alegre', 'RS');
INSERT INTO `WKTeste`.`clientes` (`codigo`, `nome`, `cidade`, `uf`) VALUES (10, 'Cliente #10', 'Passo Fundo', 'RS');
INSERT INTO `WKTeste`.`clientes` (`codigo`, `nome`, `cidade`, `uf`) VALUES (11, 'Cliente #11', 'Concórdia', 'SC');
INSERT INTO `WKTeste`.`clientes` (`codigo`, `nome`, `cidade`, `uf`) VALUES (12, 'Cliente #12', 'Curitibanos', 'SC');
INSERT INTO `WKTeste`.`clientes` (`codigo`, `nome`, `cidade`, `uf`) VALUES (13, 'Cliente #13', 'Florianópolis', 'SC');
INSERT INTO `WKTeste`.`clientes` (`codigo`, `nome`, `cidade`, `uf`) VALUES (14, 'Cliente #14', 'São Pedro de Alcântara', 'SC');
INSERT INTO `WKTeste`.`clientes` (`codigo`, `nome`, `cidade`, `uf`) VALUES (15, 'Cliente #15', 'Palhoça', 'SC');
INSERT INTO `WKTeste`.`clientes` (`codigo`, `nome`, `cidade`, `uf`) VALUES (16, 'Cliente #16', 'Lajes', 'SC');
INSERT INTO `WKTeste`.`clientes` (`codigo`, `nome`, `cidade`, `uf`) VALUES (17, 'Cliente #17', 'Biguaçu', 'SC');
INSERT INTO `WKTeste`.`clientes` (`codigo`, `nome`, `cidade`, `uf`) VALUES (18, 'Cliente #18', 'Blumenau', 'SC');
INSERT INTO `WKTeste`.`clientes` (`codigo`, `nome`, `cidade`, `uf`) VALUES (19, 'Cliente #19', 'Ibirama', 'SC');
INSERT INTO `WKTeste`.`clientes` (`codigo`, `nome`, `cidade`, `uf`) VALUES (20, 'Cliente #20', 'Alpestre', 'SC');

COMMIT;


-- -----------------------------------------------------
-- Data for table `WKTeste`.`produtos`
-- -----------------------------------------------------
START TRANSACTION;
USE `WKTeste`;
INSERT INTO `WKTeste`.`produtos` (`codigo`, `descricao`, `precoVenda`) VALUES (1, 'Produto #1', 10.5);
INSERT INTO `WKTeste`.`produtos` (`codigo`, `descricao`, `precoVenda`) VALUES (2, 'Produto #2', 100.35);
INSERT INTO `WKTeste`.`produtos` (`codigo`, `descricao`, `precoVenda`) VALUES (3, 'Produto #3', 20);
INSERT INTO `WKTeste`.`produtos` (`codigo`, `descricao`, `precoVenda`) VALUES (4, 'Produto #4', 1.99);
INSERT INTO `WKTeste`.`produtos` (`codigo`, `descricao`, `precoVenda`) VALUES (5, 'Produto #5', 35.65);
INSERT INTO `WKTeste`.`produtos` (`codigo`, `descricao`, `precoVenda`) VALUES (6, 'Produto #6', 15.05);
INSERT INTO `WKTeste`.`produtos` (`codigo`, `descricao`, `precoVenda`) VALUES (7, 'Produto #7', 1354.45);
INSERT INTO `WKTeste`.`produtos` (`codigo`, `descricao`, `precoVenda`) VALUES (8, 'Produto #8', 2815.89);
INSERT INTO `WKTeste`.`produtos` (`codigo`, `descricao`, `precoVenda`) VALUES (9, 'Produto #9', 32.48);
INSERT INTO `WKTeste`.`produtos` (`codigo`, `descricao`, `precoVenda`) VALUES (10, 'Produto #10', 68.64);
INSERT INTO `WKTeste`.`produtos` (`codigo`, `descricao`, `precoVenda`) VALUES (11, 'Produto #11', 348.48);
INSERT INTO `WKTeste`.`produtos` (`codigo`, `descricao`, `precoVenda`) VALUES (12, 'Produto #12', 254.81);
INSERT INTO `WKTeste`.`produtos` (`codigo`, `descricao`, `precoVenda`) VALUES (13, 'Produto #13', 5.48);
INSERT INTO `WKTeste`.`produtos` (`codigo`, `descricao`, `precoVenda`) VALUES (14, 'Produto #14', 6);
INSERT INTO `WKTeste`.`produtos` (`codigo`, `descricao`, `precoVenda`) VALUES (15, 'Produto #15', 846.78);
INSERT INTO `WKTeste`.`produtos` (`codigo`, `descricao`, `precoVenda`) VALUES (16, 'Produto #16', 48.98);
INSERT INTO `WKTeste`.`produtos` (`codigo`, `descricao`, `precoVenda`) VALUES (17, 'Produto #17', 16.79);
INSERT INTO `WKTeste`.`produtos` (`codigo`, `descricao`, `precoVenda`) VALUES (18, 'Produto #18', 284.84);
INSERT INTO `WKTeste`.`produtos` (`codigo`, `descricao`, `precoVenda`) VALUES (19, 'Produto #19', 361);
INSERT INTO `WKTeste`.`produtos` (`codigo`, `descricao`, `precoVenda`) VALUES (20, 'Produto #20', 22.65);

COMMIT;

