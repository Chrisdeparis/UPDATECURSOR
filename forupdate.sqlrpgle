    Dcl-DS EmplRec  extname(Employee);
    End-DS;

    exec sql
      set option commit=*none,closqlcsr=*endmod;
    
    exec sql
      declare EmpCursor cursor for
      select * from Employee
      for update of Salary;
    
    DOW '1';
      
      exec sql
        fetch EmpCursor into :EmplRec;
      
      IF SqlStt <> '00000';
        LEAVE;
      ENDIF;
      
      IF AType = 'W';
        Salary *= 1.04;
        exec sql
          update Employee set Salary = :Salary
          where current of EmpCursor;
        
      ENDIF;
      
    ENDDO;

    exec sql
      close EmpCursor;
        
        
        *inlr = *on;
