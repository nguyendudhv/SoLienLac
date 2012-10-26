<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Account_model extends CI_Model{
    public function __construct()
    {
        parent::__construct();
    }
    
    public function get_All()
    {
        //$this->db->select('AccountId,UserName,Email');
        //$this->db->from('Accounts');
       $sql = "SELECT `AccountId`,`UserName`,`Email` FROM Accounts";
       $query=$this->db->query($sql);
       $result=array();
       return json_encode($query->result());
       //return json_encode($result);
    }
   
   /*
    * Hàm kiểm tra sự tồn tại của username
    * */
   public function check_exist_username($username)
   {
       $sql = "SELECT * FROM Accounts WHERE UserName = ?";
       $query=$this->db->query($sql,array($username));
       return $query->num_rows()>0?TRUE:FALSE;
   }
   
   /*
    * Hàm kiểm tra sự tồn tại của Id
    * */
   public function check_exist_by_id($Id)
   {
       $sql = "SELECT * FROM Accounts WHERE AccountId = ?";
       $query=$this->db->query($sql,array($Id));
       return $query->num_rows()>0?TRUE:FALSE;
   }
   
    /*
    * Hàm kiểm tra sự tồn tại của username
    * */
   public function check_exist_password($password,$username)
   {
       $sql = "SELECT * FROM Accounts WHERE Password = ? AND UserName = ?"; 
       $query=$this->db->query($sql,array(md5($password),$username));
       return $query->num_rows()>0?TRUE:FALSE;
   }
   
   public function delete_by_id($Id)
   {
       $sql = "DELETE FROM Accounts WHERE AccountId = ?"; 
       $query=$this->db->query($sql,array($Id));
       return $this->db->affected_rows();
   }
}
?>