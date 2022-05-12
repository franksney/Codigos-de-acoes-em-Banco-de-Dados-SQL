/*CODIGO PRA CRIAR UM BANCO DE DADOS*/
create database escola

/*CODIGO PRA EXCUIR UMA TABELA*/
drop table Aluno

/*CODIGO PRA INCLUIR CAMPO NA TABELA*/
alter table pecas add valor varchar(20)

/*CODIGO PRA BUSCAR UMA TABELA ESPECIFICA*/
select * from PLetivo

/*CODIGO PRA INSERIR DADOS NA TABELA*/
insert into ID_ORDEM_SERV(ID_ORDEM_SERV,ID_PECAS,QUANTIDADE)
values('amortecedor','Vectra','Chevrolet','100,00')

/*CODIGO PRA MUDAR O TIPO DA COLUNA*/
ALTER TABLE FUNCIONARIO ALTER COLUMN ID_CATEGORIA INT

/*CODIGO PRA ADCIONAR INFOMACAO EM UMA COLUNA*/
update PECAS set VALOR = 100 where ID_PECA = 1

/*CODIGO PRA LIGAR UMA TABELA A OUTRA*/
alter table Aluno
add constraint FK_ALUNO_CIDADE
foreign key (codcidade) references cidade 

/*CODIGO PRA INCLUIR COLUNA EM UMA TABELA*/
ALTER TABLE CATEGORIA
ADD SALARIO INT

/*CODIGO PRA CRIAR UMA TABELA*/
create table PLetivo(
CodPeriodo int  not null primary key identity (1,1),
DsPeriodo varchar(50),
DtInicio datetime,
DtFim datetime
)

/*CODIGO PRA ALTERAR TIPO DA COLUNA*/
ALTER TABLE PECAS
ALTER COLUMN VALOR INT

ALTER TABLE CATEGORIA 
ALTER COLUMN SALARIO INT

/*CODIGO PARA INSERIR "VALOR" EM UMA COLUNA*/
update PECAS set VALOR = 480 where ID_PECA = 3

/*CODIGO PARA "SELECT ENTRE TABELAS"*/
select o.ID_ORDEM_SERV, p.VALOR, p.NOME_PECA 
from PECAS p,ORDEM_SERVCO o, OS_PECA v
where p.ID_PECA = v.ID_PECAS and v.ID_ORDEM_SERV = o.ID_ORDEM_SERV
and o.ID_ORDEM_SERV = 1

/*CODIGO PARA "SELECT ENTRE TABELAS" 'usando inner join' "EM COMUM ENTRE AS TABELAS" */
select p.preco, p.descricao
from PECAS p 
inner join OS_VENDA v on v.COD_PECA = ID_PECA
inner join os o on o. ID_OS = v.COD_OS
and o.ID_OS = 1

SET para atribuir valor

/*CODIGO PRAR CRIAR UMA "PROCEDURE" */
create procedure sp_consulta_peca_nome
@peca varchar (50)
as 
set @peca = @peca
select * from PECAS where NOME_PECA like '%' + @peca + '%'

/*CODIGO PRAR CONSULTA UMA "PROCEDURE" */
exec sp_consulta_peca_nome 'p'

/*CODIGO PARA CRIAR UMA "PROCEDURE" PARA DELETAR UM ITEM */
CREATE procedure delet_peca_nome
@peca int
as
set @peca = @peca
delete from PECAS where ID_PECA=@peca

/*CODIGO PRAR EXCLUIR NA "PROCEDURE" */
exec delet_peca_nome 7

pecas, os. cliente
select * from cliente
select * from veiculo
select * from ORDEM_SERVCO
select * from funcionario
select * from categoria
select * from PECAS
select * from OS_PECA

/*CODIGO DE CRIACAO DE PROCEDURE*/
create procedure sp_cad_pecas
@nome_peca varchar(30),
@veiculo varchar(30),
@marca varchar(20),
@valor int
as
begin
	insert into PECAS(NOME_PECA,VEICULO,MARCA,VALOR)
	values(@nome_peca,@veiculo,@marca,@valor)
end

EXEC sp_cad_pecas 'CARDAM','D20','CHEVROLET',600

/*CODIGO PARA EXCLUIR POCEDURE*/
drop procedure sp_cliente

/*CODIGO PARA INCLUIR COLUNA EM UMA TABELA JA EXISTENTE*/
alter table pecas 
add DATA_VENDA datetime

---------------------------------------

create table log_produto(
id_log int primary key not null,
cod_peca int,
descricao varchar (50),
operacao varchar(50),
acao varchar(50),
data_operacao datetime
)
go

create TRIGGER trg_ajustaEstoque
on os_peca
for insert
as
begin
	declare @quantidade int,
			@codigo int,
			--data datetime = getdate(),
			@nome varchar(50)

	select @codigo = ID_PECAS, @quantidade=QUANT_PECA from inserted
	SET @nome = (select NOME_PECA from PECAS where ID_PECA = @codigo)
	insert into log_produto(id_log,cod_peca,descricao,operacao,acao,data_operacao)
				values(1,@codigo,@nome,'update','venda',GETDATE())

				update PECAS set estoque = estoque - @quantidade,
								data_venda = getdate() where id_peca = @codigo
end


select * from PECAS
select * from OS_PECA
select * from ORDEM_SERVCO

update PECAS set estoque = 10
insert into OS_PECA values(4,5,2)

/* CODIGO PROCEDURE DE ATUALIZACAO DE ESTOQUE */
alter procedure sp_contagem_estoque /* 'CREATE' OU 'ALTER' */

@id_peca int,
@estoque int

as
begin
	declare @QtdEstoque int;

	select  @QtdEstoque = ESTOQUE - @estoque from PECAS where ID_PECA = @ID_peca

	if @QtdEstoque < 0
	begin
		SELECT 'Estoque Insuficiente' as ATENÇÃO;
		
	end
	else
		begin
			update PECAS set estoque = estoque - @estoque where id_peca = @id_peca
		end
end
go
-------------------------------
/*CODIGO PARA EXECUTAR PROCEDURE*/
exec sp_contagem_estoque 4,12

-------------------------------
/* CODIGO PARA 'UPDATE' */
update pecas set estoque = 10

select * from pecas 
--------------------------------------
/* CODIGO PARA CRIAR UMA VIEW 'com relacionamentos entre tabelas' */
create VIEW V_Consulta_OS
as
select o.ID_ORDEM_SERV as Numero_OS,c.nome, p.NOME_PECA as peca, p.VALOR 
from PECAS p,ORDEM_SERVCO o, OS_PECA v, cliente c
where p.ID_PECA = v.ID_PECAS and v.ID_ORDEM_SERV = o.ID_ORDEM_SERV and c.ID_Cliente = o.ID_CLIENTE

/* CODIGO PARA CONSULTAR UMA "VIEW" */
select nome, peca, Numero_OS, VALOR from V_consulta_OS
