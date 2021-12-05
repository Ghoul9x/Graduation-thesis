<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/**
 * 
 */
class Booking_model extends CI_Model
{
	public $tbl_booking='booking';

	public function __construct()
	{
		# code...
		parent::__construct();
	}

	public function bookingNow($object)
	{
		return $this->db->insert($this->tbl_booking, $object);
	}
}