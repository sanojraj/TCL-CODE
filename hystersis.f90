program test01
integer(8):: N  
real*8,dimension(1:600000)::rx                
real(8), allocatable :: boa(:,:),boa1(:,:),boa2(:,:)         
character(len=6), allocatable :: atom(:,:) 
integer(8) :: i,j,k,start,start1,start2,N1,a         
real*8::summ,sum1

read*,N1
    filename = '' 
    open (10, file="O-frs_10.xyz", status='OLD') 
    open (1, file="test222.txt", status='unknown') 

start =1
    do j =1,N1
    read(10,*) N
    !print*,N
    allocate (boa(N,4))
    allocate (boa1(N,4))
    allocate (boa2(N,4))
    allocate (atom(N,1))
    read (10,*) nam
    !print*, nam
        do i =start,N
            read(10,*) atom(i,1), boa(i,2:4)
            !read(10,*)  boa(i,2:4)
        end do
        do i = start,N
           	if (atom (i,1) == "FC") then 
	           boa1(i,2:4)=boa(i,2:4)
            !print*,boa(i,2:4)
            elseif (atom(i,1)=="FD") then
            !print*,i
            !print*, atom(i,1), boa(i,2:4) !checking
            boa1(i,2:4)=boa(i,2:4)

            !print*,boa(i,2:4)
            end if
     end do
     summ =0.0
start1=1
start2=10
do k=1,N/10
!print*,start1,start2
!print*,boa1(start2,2:4),boa1(start1,2:4)
boa2(k,2:4)=boa1(start2,2:4)-boa1(start1,2:4)
summ = summ+ boa2(k,4)/dsqrt((boa2(k,2))**2 + (boa2(k,3))**2 + (coa2(k,4))**2)
!print*,boa2(k,4)/dsqrt((boa2(k,2))**2 + (boa2(k,3))**2 + (coa2(k,4))**2)
start1=start1+10
start2=start2+10
!print*,summ
end do
write(1,*)summ
deallocate (boa)
deallocate (atom)
deallocate (boa1)
deallocate (boa2)

end do
    close (10) 
    close (1)
!!!!!AVERAGING DIPOLE 

!open (unit=2, file='1.txt', status='unknown')
open (unit=2, file='test222.txt', status='unknown')
open (unit=100, file='test222', status='unknown')

do i = 1,N1
read(2,*)rx(i)
end do

!do i = 1,30000
!write(1,*)i,rx(i)
!end do
a=1
do 100 i=1,N1/100
sum1 = 0.0
   do 200 j=a,a+99
  sum1 = sum1 +rx(j)

   200 continue
!write(1,*)j,sum1/real(6.0

write(100,*)2001-1*i,sum1/real(100.0)
a=a+100
100 continue
!print*,a
close(2)
close(100)
end program test01

