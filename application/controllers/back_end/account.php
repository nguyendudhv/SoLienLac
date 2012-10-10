<?php if(!define('BASEPATH')) exit('No direct script access allowed');
class Account extends Base{
    
    public function __construct()
    {
        parent::__construct();
        $this->load->model('Account_model);
    }
    public function Index()
    {
        
    }
    
    /*
     *Method account/login
     * HttpPost 
     */
    public  function Login()
    {
        $this->load->helper("form");
        $this->load->view("back_end/login.tpl");
    }
    public  function DoLogin()
    {
        $this->load->library("form_validation");
        $this->form_validation->set_rules("username", "Username", "trim|required|xss_clean");
        $this->form_validation->set_rules("password","Password","trim|required|xss_clean|callback_check_database");
        if($this->form_validation->run() == FALSE)
        {
          //Field validation failed.  User redirected to login page
          $this->load->view("back_end/login_view.tpl");
        }
        else 
        {
            
        }
    }
    
    public function check_database($password)
    {
        $username=$this->input->post("username");
        
    }
}
?>