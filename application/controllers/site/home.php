<?php
	/**
	 * 
	 */
	class home extends CI_Controller
	{	
		function __construct()
		{
			# code...
			parent::__construct();
			$this->load->model('Menu_model');
			$this->load->model('model_products');
			$this->load->model('model_category');
		}

		public function Index()
		{
			
			// $data = json_decode(json_encode($this->Menu_model->get()), true);

			// $data['product_all'] = $data;
			
			$products_data = json_decode(json_encode($this->Menu_model->get()), true);
			$products_data['product_all'] = $products_data;
   			$this->load->view('site/index',$products_data);
        
   //      	foreach ($category_data as $k => $v) {
   //         		$result[$k]['category'] = $v;
   //          	$result[$k]['products'] = $this->model_products->getProductDataByCat($v['id']);
   //      	}

			
		}
	}
?>