create database LibraryDB

use LibraryDB

create table Authors (
    [Id] int identity(1,1) primary key,
    [Name] nvarchar(50) not null,
    [Surname] nvarchar(50) not null
)

create table Books (
    [Id] int identity(1,1) primary key,
    [Name] nvarchar(100) not null unique,
    [PageCount] int not null check ([PageCount] > 10),
    [AuthorId] int foreign key references Authors(Id),
    check (len([Name]) > 2)
)

Insert into Authors 
values
('F. Scott','Fitzgerald'),('Harper','Lee'),('George','Orwell'),('Jane','Austen'),('J.D.','Salinger')


Insert into Books
values
('The Great Gatsby',180,1),('To Kill a Mockingbird',281,2),('1984',328,3),('Pride and Prejudice',432,4),('The Catcher in the Rye',277,5),('Animal Farm',112,3)



select 
    Books.Id as BookId,
    Books.Name as BookName,
    Books.PageCount,
    (Authors.Name + ' ' + Authors.Surname) as [Author FullName]
from Books
join Authors on Books.AuthorId = Authors.Id

create view GetFullInfoBook as
select 
    Books.Id as BookId,
    Books.Name as BookName,
    Books.PageCount,
    (Authors.Name + ' ' + Authors.Surname) as [Author FullName]
from Books
join Authors on Books.AuthorId = Authors.Id

select * from GetFullInfoBook

create view AuthorBooksInfo 
as
select 
    (Authors.Name + ' ' + Authors.Surname) as [Author FullName],
    max(Books.PageCount) as MaxPageCount,
    count(*) as BookCount
from Books
join Authors on Books.AuthorId = Authors.Id
group by Authors.Name, Authors.Surname


select 
    (Authors.Name + ' ' + Authors.Surname) as [Author FullName],
    max(Books.PageCount) as MaxPageCount,
    count(*) as BookCount
from Books
join Authors on Books.AuthorId = Authors.Id
group by Authors.Name, Authors.Surname

select * from AuthorBooksInfo



create procedure SearchBooks @Name nvarchar(100)
as
begin
    select 
        Books.Id as BookId,
        Books.Name as BookName,
        Books.PageCount,
        (Authors.Name + ' ' + Authors.Surname) as [Author FullName]
    from Books
    join Authors on Books.AuthorId = Authors.Id
    where Books.Name = @Name 
       or Authors.Name = @Name
       or Authors.Surname = @Name;
end

exec SearchBooks 'George'


-- Delete Author

create procedure DeleteAuthor @Id int
as
begin
    delete from Authors where Id = @Id
end



-- Insert Author

create procedure InsertAuthor @Name nvarchar(100),@Surname nvarchar(100)
as
begin
    insert into Authors
    values (@Name, @Surname)
end

-- Update Author

create procedure UpdateAuthor
    @Id int,
    @Name nvarchar(100),
    @Surname nvarchar(100)
as
begin
    update Authors
    set Name = @Name, Surname = @Surname
    where Id = @Id
end

select * from Authors

exec UpdateAuthor 6,'Anar','Balacayev'

exec InsertAuthor 'Xaqan','Ismayilov'

exec DeleteAuthor 7


-- Muellim men hemise tasklari gite yuklemek ucun database sag klik edib generate script edib hemin
-- script faylin yuklemisem,ona gore elave olaraq bunu yukleyirem,cunki hemin script faylinda yazdigim
-- queryler gorunmurdu


