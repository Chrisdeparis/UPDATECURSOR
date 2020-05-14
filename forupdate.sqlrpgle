    D CustData      e ds                  extname(CustMaster)
D ChangeCode      s              1p 0

/free                              
     exec sql                       
        declare Customer cursor for 
           select * from CustMaster
            where state = 'TX'      
              for update of chgcod;

     exec sql                       
        open Customer;              
        // insert code to check for open error
                                    
     dow '1';                       
        exec sql                    
           fetch Customer into :CustData;
        if sqlstt = '02000';        
           leave;                   
        endif;                      
        // insert code to check for fetch error

        // insert calcs to calculate new Change Code here
        // eval whatever ...
        // call whatever ...
        // etc.

        // ChangeCode now has a new value for the customer.
        
     exec sql                       
           update CustMaster set chgcod = :ChangeCode
              where current of Customer;
     enddo;                         
     exec sql                       
        close Customer;             
        // insert code to check for close error
     return;                        
