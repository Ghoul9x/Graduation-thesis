<?php 
/**
 * 
 */
class Booking extends CI_Controller
{
	

	public function __construct()
	{
		# code...
		parent::__construct();
		$this->load->model('Booking_model');
	}

	public function index()
	{

	}

	public function bookingNow()
	{
		$object = $this->input->post();
		
		if($this->Booking_model->bookingNow($object)){
			echo '<script type="text/javascript">';
			echo 'alert("Đặt bàn thành công, nhà hàng sẽ liên hệ lại với bạn!");';
			echo '</script>';
			//sau khi đặt bàn thành công thì gửi email cho khách hàng và admin

		}else{
			echo '<script type="text/javascript">';
			echo 'alert("Đặt bàn không thành công, có lỗi hệ thống xảy ra");';
			echo '</script>';
		}
		
	}

}
?>