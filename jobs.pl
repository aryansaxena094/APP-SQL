person(1,nathaniel_ford).
person(2,gary_jimenez).
person(3,albert_pardini).
person(4,christopher_chong).
person(5,patrick_gardner).
person(6,david_sullivan).
person(7,alson_lee).
person(8,david_kushner).
person(9,michael_morris).
person(10,arthur_kenney).
person(11,patricia_jackson).
person(12,edward_harrington).
person(13,john_martin).
person(14,david_franklin).
person(15,amy_hart).

employee(1,1,04-06-2002,39343,1).
employee(2,3,31-12-2001,57081,2).
employee(3,5,08-10-2001,46205,1).
employee(4,2,25-07-2001,61111,3).
employee(5,7,25-06-2001,37731,3).
employee(6,15,16-07-1998,66029,1).

freelancer(1,4,programmer).
freelancer(2,6,tester).
freelancer(3,8,marketing).
freelancer(4,9,data_scientist).
freelancer(5,11,graphic_designer).
freelancer(6,12,system_administrator).

company(1,niko_resources_limited,belgium ,2).
company(2,worldwide_resources_holdings_ltd,austria,5).
company(3,solvay_s_a_belgium,iceland,15).

jobs(1,23,18-06-2002,1,2,2).
jobs(2,34,01-12-2001,1,2,3).
jobs(3,28,08-09-2001,1,1,1).
jobs(4,15,12-07-2001,1,1,5).
jobs(5,18,28-06-2001,1,3,6).
jobs(6,29,16-07-1998,1,3,1).
jobs(7,42,19-05-2010,1,3,4).



getCompany(Name,X):-
    company(Id,Name,_,_).

getEmployee(Name,PName):-
    getCompany(Name,Id),
    employee(_,Id,_,_,_),
    person(Id,PName).

findAllEmployee(Name,List):-
    findall(X,getEmployee(Name,X),List).


helperGetFreelancers(CName,Spec,PName):-
    getCompany(CName,Cid),
    jobs(_,_,_,_,Cid,Fid),
    freelancer(Fid,Pid,Spec),
    person(Pid,PName).

getFreelancers(CName,Spec,Set):-
    findall(X,helperGetFreelancers(CName,Spec,X),List),
    list_to_set(List, Set).

amountGreaterThan(Amount,Fid):-
    jobs(_,Pay,_,_,_,Fid),
	Pay > Amount.

helperAllFreelancersGreaterThanSomeGivenAmount(Amount,PName):-
    amountGreaterThan(Amount,Fid),
    freelancer(Fid,Pid,_),
    person(Pid,PName).

allFreelancersGreaterThanSomeGivenAmount(Amount,Set):-
    findall(X,helperAllFreelancersGreaterThanSomeGivenAmount(Amount,X),List),
    list_to_set(List, Set).

managedBy(Comp,Pname,Salary):-
    company(_,Comp,_,ManagedBy),
    employee(_,ManagedBy,_,Salary,_),
    person(ManagedBy,Pname).