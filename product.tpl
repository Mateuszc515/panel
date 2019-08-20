{*
* 2007-2015 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
* @author PrestaShop SA <contact@prestashop.com>
    * @copyright 2007-2015 PrestaShop SA
    * @license http://opensource.org/licenses/afl-3.0.php Academic Free License (AFL 3.0)
    * International Registered Trademark & Property of PrestaShop SA
    *}
    {include file="$tpl_dir./errors.tpl"}
    {if $errors|@count == 0}
    {if !isset($priceDisplayPrecision)}
    {assign var='priceDisplayPrecision' value=2}
    {/if}
    {if !$priceDisplay || $priceDisplay == 2}
    {assign var='productPrice' value=$product->getPrice(true, $smarty.const.NULL, 6)}
    {assign var='productPriceWithoutReduction' value=$product->getPriceWithoutReduct(false, $smarty.const.NULL)}
    {elseif $priceDisplay == 1}
    {assign var='productPrice' value=$product->getPrice(false, $smarty.const.NULL, 6)}
    {assign var='productPriceWithoutReduction' value=$product->getPriceWithoutReduct(true, $smarty.const.NULL)}
    {/if}
    <div itemscope itemtype="https://schema.org/Product">
        <meta itemprop="url" content="{$link->getProductLink($product)}">
        <div class="primary_block row">
            {if !$content_only}
            <div class="container">
                <div class="top-hr"></div>
            </div>
            {/if}
            {if isset($adminActionDisplay) && $adminActionDisplay}
            <div id="admin-action" class="container">
                <p class="alert alert-info">{l s='This product is not visible to your customers.'}
                    <input type="hidden" id="admin-action-product-id" value="{$product->id}" />
                    <a id="publish_button" class="btn btn-outline button button-small" href="#">
                        <span>{l s='Publish'}</span>
                    </a>
                    <a id="lnk_view" class="btn btn-outline button button-small" href="#">
                        <span>{l s='Back'}</span>
                    </a>
                </p>
                <p id="admin-action-result"></p>
            </div>
            {/if}
            {if isset($confirmation) && $confirmation}
            <p class="confirmation">
                {$confirmation}
            </p>
            {/if}
            <!-- left infos-->
            <div class="pb-left-column col-xs-12 col-sm-12 col-md-5">
                <!-- product img-->
                <div id="image-block" class="clearfix">
                    <div class="p-label">
                        {if $product->new}
                        <span class="label-new label label-info">{l s='New'}</span>
                        {/if}
                        {if $product->on_sale}
                        <span class="label-sale label label-warning">{l s='Sale!'}</span>
                        {elseif $product->specificPrice && $product->specificPrice.reduction && $productPriceWithoutReduction > $productPrice}
                        <span class="label-discount label label-danger">{l s='Reduced price!'}</span>
                        {/if}
                    </div>
                    {if $have_image}
                    <span id="view_full_size">
                        {if $jqZoomEnabled && $have_image && !$content_only}
                        <a class="jqzoom" title="{if !empty($cover.legend)}{$cover.legend|escape:'html':'UTF-8'}{else}{$product->name|escape:'html':'UTF-8'}{/if}" rel="gal1" href="{$link->getImageLink($product->link_rewrite, $cover.id_image, 'thickbox_default')|escape:'html':'UTF-8'}">
                            <img class="img-responsive" itemprop="image" src="{$link->getImageLink($product->link_rewrite, $cover.id_image, 'large_default')|escape:'html':'UTF-8'}" title="{if !empty($cover.legend)}{$cover.legend|escape:'html':'UTF-8'}{else}{$product->name|escape:'html':'UTF-8'}{/if}" alt="{if !empty($cover.legend)}{$cover.legend|escape:'html':'UTF-8'}{else}{$product->name|escape:'html':'UTF-8'}{/if}" />
                        </a>
                        {else}
                        <img id="bigpic" class="img-responsive" itemprop="image" src="{$link->getImageLink($product->link_rewrite, $cover.id_image, 'large_default')|escape:'html':'UTF-8'}" title="{if !empty($cover.legend)}{$cover.legend|escape:'html':'UTF-8'}{else}{$product->name|escape:'html':'UTF-8'}{/if}" alt="{if !empty($cover.legend)}{$cover.legend|escape:'html':'UTF-8'}{else}{$product->name|escape:'html':'UTF-8'}{/if}" width="{$largeSize.width}" height="{$largeSize.height}" />
                        {if !$content_only}
                        <!--  <span class="span_link no-print status-enable"></span>-->
                        {/if}
                        {/if}
                    </span>
                    {else}
                    <span id="view_full_size">
                        <img itemprop="image" src="{$img_prod_dir}{$lang_iso}-default-large_default.jpg" id="bigpic" alt="" title="{$product->name|escape:'html':'UTF-8'}" width="{$largeSize.width}" height="{$largeSize.height}" />
                        {if !$content_only}
                        <span class="span_link">
                            {l s='View larger'}
                        </span>
                        {/if}
                    </span>
                    {/if}
                </div> <!-- end image-block -->
                {if isset($images) && count($images) > 0}
                <!-- thumbnails -->
                <div id="views_block" class="clearfix {if isset($images) && count($images) < 2}hidden{/if}">
                    {if isset($images) && count($images) > 2}
                    <span class="view_scroll_spacer">
                        <a id="view_scroll_left" class="" title="{l s='Other views'}" href="javascript:{ldelim}{rdelim}">
                            {l s='Previous'}
                        </a>
                    </span>
                    {/if}
                    <div id="thumbs_list">
                        <ul id="thumbs_list_frame">
                            {if isset($images)}
                            {foreach from=$images item=image name=thumbnails}
                            {assign var=imageIds value="`$product->id`-`$image.id_image`"}
                            {if !empty($image.legend)}
                            {assign var=imageTitle value=$image.legend|escape:'html':'UTF-8'}
                            {else}
                            {assign var=imageTitle value=$product->name|escape:'html':'UTF-8'}
                            {/if}
                            <li id="thumbnail_{$image.id_image}" {if $smarty.foreach.thumbnails.last} class="last" {/if}> <a{if $jqZoomEnabled && $have_image && !$content_only} href="javascript:void(0);" rel="{literal}{{/literal}gallery: 'gal1', smallimage: '{$link->getImageLink($product->link_rewrite, $imageIds, 'large_default')|escape:'html':'UTF-8'}',largeimage: '{$link->getImageLink($product->link_rewrite, $imageIds, 'thickbox_default')|escape:'html':'UTF-8'}'{literal}}{/literal}" {else} href="{$link->getImageLink($product->link_rewrite, $imageIds, 'thickbox_default')|escape:'html':'UTF-8'}" data-fancybox-group="other-views" class="fancybox{if $image.id_image == $cover.id_image} shown{/if}" {/if} title="{$imageTitle}">
                                <img class="img-responsive" id="thumb_{$image.id_image}" src="{$link->getImageLink($product->link_rewrite, $imageIds, 'cart_default')|escape:'html':'UTF-8'}" alt="{$imageTitle}" title="{$imageTitle}" {if isset($cartSize)} height="{$cartSize.height}" width="{$cartSize.width}" {/if} itemprop="image" />
                                </a>
                            </li>
                            {/foreach}
                            {/if}
                        </ul>
                    </div> <!-- end thumbs_list -->
                    {if isset($images) && count($images) > 2}
                    <a id="view_scroll_right" title="{l s='Other views'}" href="javascript:{ldelim}{rdelim}">
                        {l s='Next'}
                    </a>
                    {/if}
                </div> <!-- end views-block -->
                <!-- end thumbnails -->
                {/if}
                {if isset($images) && count($images) > 1}
                <p class="resetimg clear no-print">
                    <span id="wrapResetImages" style="display: none;">
                        <a href="{$link->getProductLink($product)|escape:'html':'UTF-8'}" data-id="resetImages">
                            <i class="fa fa-repeat"></i>
                            {l s='Display all pictures'}
                        </a>
                    </span>
                </p>
                {/if}
            </div> <!-- end pb-left-column -->
            <!-- end left infos-->
          
            {$marka_nazwa = {$product_manufacturer->name|escape} }

            

            <!-- center infos -->
            <div class="pb-center-column col-xs-12 col-sm-12 col-md-7">
                {if $product->online_only}
                <p class="online_only">{l s='Online only'}</p>
                {/if}
                <h1 itemprop="name"><a href="{$link->getManufacturerLink($product_manufacturer->id)}" class="editable Nazwa_Producenta">{$product_manufacturer->name|escape}</a>
                    <h1 id="nazwa_produktuu" itemprop="name" class="nazwaProduktu"> </br>{$product->name|escape:'html':'UTF-8'}</h1>
<script type="text/javascript">
            var asd = document.querySelector("#nazwa_produktuu");
                var produkt = asd.innerText;
                var marka = "{$marka_nazwa}"
                var marka_wys = "";
                var nazwa_wys = "";
                for (var i = 0; i < produkt.length; i++) {
                    if (marka[i] == produkt[i]) {
                        marka_wys += produkt[i];
                    } else {
                        nazwa_wys += produkt[i];
                    }
                }
                document.getElementById("nazwa_produktu").innerHTML = nazwa_wys;

            </script>


                    <script>
                        document.getElementById("nazwa_produktu").innerHTML = nazwa_wys;                        
                    </script>
                    <div>
                        <p id="kategorie_produktu"></p>
                    </div>
                    <!--cena-->
                    <div class="content_prices clearfix">
                        {if $product->show_price && !isset($restricted_country_mode) && !$PS_CATALOG_MODE}
                        <!-- prices -->
                        <div class="price">
                            <p class="our_price_display" itemprop="offers" itemscope itemtype="https://schema.org/Offer">{strip}
                                {if $product->quantity > 0}
                                <link itemprop="availability" href="https://schema.org/InStock" />{/if}
                                {if $priceDisplay >= 0 && $priceDisplay <= 2} <span id="our_price_display" class="price" itemprop="price" content="{$productPrice}">{convertPrice price=$productPrice|floatval}</span>

                                    <meta itemprop="priceCurrency" content="{$currency->iso_code}" />
                                    {hook h="displayProductPriceBlock" product=$product type="price"}
                                    {/if}
                                    {/strip}</p>
                            <p id="old_price" {if (!$product->specificPrice || !$product->specificPrice.reduction)} class="hidden"{/if}>{strip}
                                {if $priceDisplay >= 0 && $priceDisplay <= 2} {hook h="displayProductPriceBlock" product=$product type="old_price" } <span id="old_price_display"><span class="price">{if $productPriceWithoutReduction > $productPrice}{convertPrice price=$productPriceWithoutReduction|floatval}{/if}</span></span>
                                    {/if}
                                    {/strip}</p>
                            <p id="reduction_percent" {if !$product->specificPrice || $product->specificPrice.reduction_type != 'percentage'} style="display:none;"{/if}>{strip}
                                <span id="reduction_percent_display">
                                    {if $product->specificPrice && $product->specificPrice.reduction_type == 'percentage'}-{$product->specificPrice.reduction*100}%{/if}
                                </span>
                                {/strip}</p>
                            <div class="testowiec">
                                <p id="reduction_amount" {if !$product->specificPrice || $product->specificPrice.reduction_type != 'amount' || $product->specificPrice.reduction|floatval ==0} style="display:none"{/if}>{strip}
                                    <span id="reduction_amount_display">
                                        {if $product->specificPrice && $product->specificPrice.reduction_type == 'amount' && $product->specificPrice.reduction|floatval !=0}
                                        -{convertPrice price=$productPriceWithoutReduction|floatval-$productPrice|floatval}
                                        {/if}
                                    </span>
                                    {/strip}</p>
                            </div>
                            {if $priceDisplay == 2}
                            <br />
                            <span id="pretaxe_price">{strip}
                                <span id="pretaxe_price_display">{convertPrice price=$product->getPrice(false, $smarty.const.NULL)}</span> {l s='tax excl.'}
                                {/strip}</span>
                            {/if}
                        </div> <!-- end prices -->

                        {if $packItems|@count && $productPrice < $product->getNoPackPrice()}
                            <p class="pack_price">{l s='Instead of'} <span style="text-decoration: line-through;">{convertPrice price=$product->getNoPackPrice()}</span></p>
                            {/if}
                            {if $product->ecotax != 0}
                            <p class="price-ecotax">{l s='Including'} <span id="ecotax_price_display">{if $priceDisplay == 2}{$ecotax_tax_exc|convertAndFormatPrice}{else}{$ecotax_tax_inc|convertAndFormatPrice}{/if}</span> {l s='for ecotax'}
                                {if $product->specificPrice && $product->specificPrice.reduction}
                                <br />{l s='(not impacted by the discount)'}
                                {/if}
                            </p>
                            {/if}
                            {if !empty($product->unity) && $product->unit_price_ratio > 0.000000}
                            {math equation="pprice / punit_price" pprice=$productPrice punit_price=$product->unit_price_ratio assign=unit_price}
                            <p class="unit-price"><span id="unit_price_display">{convertPrice price=$unit_price}</span> {l s='per'} {$product->unity|escape:'html':'UTF-8'}</p>
                            {hook h="displayProductPriceBlock" product=$product type="unit_price"}
                            {/if}
                            {/if} {*close if for show price*}
                            {hook h="displayProductPriceBlock" product=$product type="weight" hook_origin='product_sheet'}
                            {hook h="displayProductPriceBlock" product=$product type="after_price"}
                            <div class="clear"></div>
                    </div> <!-- end content_prices -->
                    <!--koneic ceny-->
                    <!--                   ilosć w koszyku-->
                    {if !$PS_CATALOG_MODE}
                    <p id="quantity_wanted_p" {if (!$allow_oosp && $product->quantity <= 0) || !$product->available_for_order || $PS_CATALOG_MODE} style="display: none;"{/if}>
                            <a href="#" data-field-qty="qty" class="btn2 status-enable button-minus btn-sm product_quantity_down">
                                <i class="fa fa-minus"></i>
                            </a>
                            <input type="text" min="1" name="qty" id="quantity_wanted" class="text form-control" value="{if isset($quantityBackup)}{$quantityBackup|intval}{else}{if $product->minimal_quantity > 1}{$product->minimal_quantity}{else}1{/if}{/if}" />

                            <a href="#" data-field-qty="qty" class="btn2 status-enable button-plus btn-sm product_quantity_up">
                                <i class="fa fa-plus"></i>
                            </a>
                            <span class="clearfix"></span>
                    </p>
                    {/if}


                    <!-- minimal quantity wanted -->
                    <p id="minimal_quantity_wanted_p" {if $product->minimal_quantity <= 1 || !$product->available_for_order || $PS_CATALOG_MODE} style="display: none;"{/if}>
                            {l s='The minimum purchase order quantity for the product is'} <b id="minimal_quantity_label">{$product->minimal_quantity}</b>
                    </p>
                    <!--                        koniec ilosć w koszyku -->
                    <!--                   dodaj do koszyka-->
                    <div {if (!$allow_oosp && $product->quantity <= 0) || !$product->available_for_order || (isset($restricted_country_mode) && $restricted_country_mode) || $PS_CATALOG_MODE} class="unvisible"{/if}>
                            <p id="add_to_cart" class="buttons_bottom_block no-print">
                                <button type="submit" name="Submit" class="exclusive btn btn-outline">
                                    <span>{if $content_only && (isset($product->customization_required) && $product->customization_required)}{l s='Customize'}{else}<i class="fa fa-shopping-cart"></i>{l s='Add to cart'}{/if}</span>
                                </button>
                            </p>
                    </div>
                    <!--                        koniec dodaj do koszyka-->

                    <p id="product_reference" {if empty($product->reference) || !$product->reference} style="display: none;"{/if}>
                        <label>{l s='Reference:'} </label>
                        <span class="editable rodzajProducenta" itemprop="sku" {if !empty($product->reference) && $product->reference} content="{$product->reference}"{/if}>{if !isset($groups)}{$product->reference|escape:'html':'UTF-8'}{/if}</span>
                    </p>
                    {if !$product->is_virtual && $product->condition}
                    <p id="product_condition">
                        <label>{l s='Condition:'} </label>
                        {if $product->condition == 'new'}
                        <link itemprop="itemCondition" href="https://schema.org/NewCondition" />
                        <span class="editable">{l s='New product'}</span>
                        {elseif $product->condition == 'used'}
                        <link itemprop="itemCondition" href="https://schema.org/UsedCondition" />
                        <span class="editable">{l s='Used'}</span>
                        {elseif $product->condition == 'refurbished'}
                        <link itemprop="itemCondition" href="https://schema.org/RefurbishedCondition" />
                        <span class="editable">{l s='Refurbished'}</span>
                        {/if}
                    </p>
                    {/if}
                    {if $product->description_short || $packItems|@count > 0}
                    <div id="short_description_block">
                        {if $product->description_short}
                        <div id="short_description_content" class="rte align_justify" itemprop="description">{$product->description_short}</div>
                        {/if}

                        {*{if $product->description}
                        <p class="buttons_bottom_block">
                            <a href="javascript:{ldelim}{rdelim}" class="button">
                                {l s='More details'}
                            </a>
                        </p>
                        {/if}*}
                        <!-- dostawa jaka cena -->


                        <!--
                            <span class= "wysylka_okienko"style="font-size: 16px;">Koszt wysyłki:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style="font-weight: 800;">od 12,00zł </span></span>
                            <td>
                                <a class="tooltips">
                                    <i class="fa fa-truck" style="color:#D20250"></i>
                                </a>
                            </td>
-->

                        <!--koniec dodstawa jaka cena-->
                        <!--{if $packItems|@count > 0}
						<div class="short_description_pack">
						<h3>{l s='Pack content'}</h3>
							{foreach from=$packItems item=packItem}

							<div class="pack_content">
								{$packItem.pack_quantity} x <a href="{$link->getProductLink($packItem.id_product, $packItem.link_rewrite, $packItem.category)|escape:'html':'UTF-8'}">{$packItem.name|escape:'html':'UTF-8'}</a>
								<p>{$packItem.description_short}</p>
							</div>
							{/foreach}
						</div>
					{/if}-->
                    </div> <!-- end short_description_block -->
                    {/if}
 <div class="product_attributes clearfix">

                        {if isset($groups)}
                        <!-- attributes -->
                        <div id="attributes" class="row">
                            <div class="clearfix"></div>
                            {foreach from=$groups key=id_attribute_group item=group}
                            {if $group.attributes|@count}
                            <fieldset class="attribute_fieldset col-lg-6 col-md-6 col-sm-12 col-xs-12">
                                <label class="attribute_label" {if $group.group_type !='color' && $group.group_type !='radio' }for="group_{$id_attribute_group|intval}" {/if}>{$group.name|escape:'html':'UTF-8'}&nbsp; </label> {assign var="groupName" value="group_$id_attribute_group" } <div class="attribute_list">
                                    {if ($group.group_type == 'select')}
                                    <select name="{$groupName}" id="group_{$id_attribute_group|intval}" class="form-control attribute_select no-print">
                                        {foreach from=$group.attributes key=id_attribute item=group_attribute}
                                        <option value="{$id_attribute|intval}" {if (isset($smarty.get.$groupName) && $smarty.get.$groupName|intval==$id_attribute) || $group.default==$id_attribute} selected="selected" {/if} title="{$group_attribute|escape:'html':'UTF-8'}">{$group_attribute|escape:'html':'UTF-8'}</option>
                                        {/foreach}
                                    </select>
                                    {elseif ($group.group_type == 'color')}
                                    <ul id="color_to_pick_list" class="clearfix">
                                        {assign var="default_colorpicker" value=""}
                                        {foreach from=$group.attributes key=id_attribute item=group_attribute}
                                        {assign var='img_color_exists' value=file_exists($col_img_dir|cat:$id_attribute|cat:'.jpg')}
                                        <li {if $group.default==$id_attribute}  {/if}> <a href="{$link->getProductLink($product)|escape:'html':'UTF-8'}" id="color_{$id_attribute|intval}" name="{$colors.$id_attribute.name|escape:'html':'UTF-8'}" class="pojem" {if !$img_color_exists && isset($colors.$id_attribute.value) && $colors.$id_attribute.value} style="background:{$colors.$id_attribute.value|escape:'html':'UTF-8'};" {/if} title="{$colors.$id_attribute.name|escape:'html':'UTF-8'}">
                                            {$group_attribute|escape:'html':'UTF-8'}
                                            





 

            <script type="text/javascript">
var asd = document.querySelector("#nazwa_produktu");
                var produkt = "";
                var przejscie = " ";
               var pusty = " ";
                var pojem = " ";
                var nazwaa = "";
                for(var g = nazwa_wys.length-1; g >0 ;g--)
                {
                    if( nazwa_wys[g] == przejscie[0])
                    {
                        break;        
                    }
                    pojem += nazwa_wys[g];
                }
                for(var z = pojem.length-1; z > 0; z--  )
{
    pusty += pojem[z];
}
for(var e = 0 ; e < nazwa_wys.length; e++)
{
    if(pusty[1] === nazwa_wys[e] && nazwa_wys[e+1] == "0")
    {
       break;
    }
    nazwaa += nazwa_wys[e];
}

                for(var d = 1; d < nazwaa.length ; d++)
                {
                    var napis = "pomoc";
                    
                   if(nazwaa[d] == przejscie[0])
                    {
                        produkt += "-";
                        
                    }
                    else{
                    produkt += nazwaa[d];
                    }
                    
                }
                var marka = "{$marka_nazwa}"
                var nazwa_link = "";
                for(var i=0 ; i<marka.length;i++)
                {
                    if(marka[i] == " ")
                    {
                        nazwa_link += "-";
                    }
                    else{
      nazwa_link += marka[i];
                    }
              
                }


                   var linkgotowy = "https://makeupmania.com.pl/sklep/"+nazwa_link+"/"+produkt;
                document.getElementById("nazwa_produktu").innerHTML = nazwa_wys;

            </script>

                    <script>
                     if(document.getElementById("color_25").innerHTML)
                    {
                        document.getElementById("color_25").href = linkgotowy + "50ml.html";
                    }
                    if(document.getElementById("color_27").innerHTML)
                    {
                        document.getElementById("color_27").href = linkgotowy + "150ml.html";
                    }
                    if(document.getElementById("color_26").innerHTML)
                    {
                        document.getElementById("color_26").href = linkgotowy + "100ml.html";
                    }
                    if(document.getElementById("color_28").innerHTML)
                    {
                        document.getElementById("color_28").href = linkgotowy + "200ml.html";
                    }
                    if(document.getElementById("color_29").innerHTML)
                    {
                        document.getElementById("color_29").href = linkgotowy + "250ml.html";
                    }
                    if(document.getElementById("color_30").innerHTML)
                    {
                        document.getElementById("color_30").href = linkgotowy + "125ml.html";
                    }
                    if(document.getElementById("color_31").innerHTML)
                    {
                        document.getElementById("color_31").href = linkgotowy + "30ml.html";
                    }
                                           
                    </script>





                                            {if $img_color_exists}
                                            <img src="{$img_col_dir}{$id_attribute|intval}.jpg" alt="{$colors.$id_attribute.name|escape:'html':'UTF-8'}" title="{$colors.$id_attribute.name|escape:'html':'UTF-8'}" width="20" height="20" />
                                            {$group_attribute|escape:'html':'UTF-8'}


                                            {/if}

                                            </a>
                                        </li>
                                        {if ($group.default == $id_attribute)}
                                        {$default_colorpicker = $id_attribute}
                                        {/if}
                                        {/foreach}
                                    </ul>
                                    <input type="hidden" class="color_pick_hidden" name="{$groupName|escape:'html':'UTF-8'}" value="{$default_colorpicker|intval}" />
                                    {elseif ($group.group_type == 'radio')}
                                    <ul>
                                        {foreach from=$group.attributes key=id_attribute item=group_attribute}
                                        <li>
                                            <input type="radio" class="attribute_radio" name="{$groupName|escape:'html':'UTF-8'}" value="{$id_attribute}" {if ($group.default==$id_attribute)} checked="checked" {/if} />
                                            <span>{$group_attribute|escape:'html':'UTF-8'}</span>
                                        </li>
                                        {/foreach}
                                    </ul>
                                    {/if}
                        </div> <!-- end attribute_list -->
                        </fieldset>
                        {/if}
                        {/foreach}
                    </div> <!-- end attributes -->
                    {/if}
                    <!-- quantity wanted -->

            </div>

                    <p id="availability_date" {if ($product->quantity > 0) || !$product->available_for_order || $PS_CATALOG_MODE || !isset($product->available_date) || $product->available_date < $smarty.now|date_format:'%Y-%m-%d'} style="display: none;" {/if}> <span id="availability_date_label">{l s='Availability date:'}</span>
                            <span id="availability_date_value">{if Validate::isDate($product->available_date)}{dateFormat date=$product->available_date full=false}{/if}</span>
                    </p>
                    <!-- Out of stock hook -->
                    <div id="oosHook" {if $product->quantity > 0} style="display: none;"{/if}>
                        {$HOOK_PRODUCT_OOS}
                    </div>
  {if ($product->show_price && !isset($restricted_country_mode)) || isset($groups) || $product->reference || (isset($HOOK_PRODUCT_ACTIONS) && $HOOK_PRODUCT_ACTIONS)}
                <!-- add to cart form-->
                <form id="buy_block" {if $PS_CATALOG_MODE && !isset($groups) && $product->quantity > 0} class="hidden"{/if} action="{$link->getPageLink('cart')|escape:'html':'UTF-8'}" method="post">
                    <!-- hidden datas -->
                    <p class="hidden">
                        <input type="hidden" name="token" value="{$static_token}" />
                        <input type="hidden" name="id_product" value="{$product->id|intval}" id="product_page_product_id" />
                        <input type="hidden" name="add" value="1" />
                        <input type="hidden" name="id_product_attribute" id="idCombination" value="" />
                    </p>
                    <div class="box-info-product">
                        <!--                      odliczanie-->
                        <div class="odliczanie">
                            {literal}


                            <div class="clock"></div>
                            <script type="text/javascript">
                                $(document).ready(function() {
                                    setInterval(function() {
                                        var now = new Date();
                                        var day = now.getDay();
                                        var end;

                                        if (day >= 1 && day <= 5) {
                                            end = new Date(now.getYear(), now.getMonth(), day, 14, 0, 0, 0);
                                            var teraz = new Date();
                                            var dzis = teraz.getHours();
                                            if (dzis < 16) {

                                                var timeleft = end.getTime() - now.getTime();
                                                var diff = new Date(timeleft);
                                                var sekunda = diff.getSeconds();
                                                if (sekunda < 10) sekunda = "0" + sekunda;
                                                var minuta = diff.getMinutes();
                                                if (minuta < 10) minuta = "0" + minuta;
                                                var godzina = diff.getHours();
                                                if (godzina < 10) godzina = "0" + godzina;
                                                $("#timeleft").html(godzina + ":" + minuta + ":" + sekunda + "");
                                                $("#tekstdowys").html("Wysyłka dzisiaj za");
                                            } else {
                                                $("#tekstdowys").html("Najbliższa wysyłka już");
                                                $("#timeleft").html("Jutro 15:00");
                                            }
                                        } else if (day == 6) {
                                            end = new Date(now.getYear(), now.getMonth(), day, 14, 0, 0, 0);
                                        } else {
                                            $("#tekstdowys").html("Najbliższa wysyłka już");
                                            $("#timeleft").html("w poniedziałek o 15:00");
                                            end = new Date(now.getYear(), now.getMonth(), day, 14, 0, 0, 0);
                                        }

                                    }, 1000);
                                });

                            </script>
                            <div class="obudowa">
                                <div id="tekstdo"><a id="tekstdowys"></a></div>
                               

                                <!--                    dostawa cena-->
                                <div class="zegar1"><a id="timeleft"></a></div>
                                <div class="costs"><span class="header">Informacje o&nbsp;dostawie</span> 
                                    <a class=" tooltips" style="color:#fff">
                        <i class="fa fa-truck moc">
                            <span class="tabela">
                                <table class="tabela2" border="1" width="120">
                                    <tbody>
                                        <tr>
                                            <td class="newTd0" style="border:1px solid #DDD;">
                                            </td>
                                            <td class="newTd" colspan="2">
                                                <p><strong>KOSZT DOSTAWY</strong></p>
                                            </td>
                                            <td class="newTd">
                                                <p><strong>CZAS DOSTAWY</strong></p>
                                            </td>
                                            <td class="newTd">
                                                <p><strong>MIEJSCE DOSTAWY</strong></p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="newTd0" style="text-align:center;border:1px solid #DDD;">

                                                <img style="width: 70px;margin-left: 3px;margin-right: -3px;margin-bottom: -16px;" src="/sklep/themes/leo_beeshop/img/modules/appagebuilder/images/inpost_logo.png">
                                            </td>
                                            <td class="newTd1">
                                                <p><strong>12,00 zł</strong></p>
                                                <p>Przedpłata</p>
                                            </td>
                                            <td class="newTd2">
                                                <p><strong>12,90 zł</strong></p>
                                                <p>Pobranie</p>
                                            </td>
                                            <td class="newTd3">
                                                <p>1-2 dni robocze od </p>
                                                <p>momentu nadania</p>
                                            </td>
                                            <td class="newTd4">
                                                <p>Na wskazany przez </p>
                                                <p>kupującego adres</p>
                                            </td>
                                        </tr>

                                      
 
                                        <tr>




                                            <td class="newTd0" style="text-align:center;border:1px solid #DDD;">

                                                <img style="width: 70px;margin-left: 3px;margin-right: -3px;margin-bottom: -16px;" src="https://makeupmania.com.pl/img/cms/PACZKOMATY%20LOGO.jpg">
                                            </td>
                                            <td class="newTd1">
                                                <p><strong>9,90 zł</strong></p>
                                                <p>Przedpłata</p>
                                            </td>
                                            <td class="newTd2">
                                                <p><strong> - </strong></p>
                                                <p>Pobranie</p>
                                            </td>
                                            <td class="newTd3">
                                                <p>1-2 dni robocze od </p>
                                                <p>momentu nadania</p>
                                            </td>
                                            <td class="newTd4">
                                                <p>Na wskazany przez </p>
                                                <p>kupującego adres</p>
                                            </td>
                                        </tr>
                                        
                                        <tr>

                                            <td class="newTd0" style="text-align:center;border:1px solid #DDD;">

                                                <img style="width: 70px;margin-left: 3px;margin-right: -3px;margin-bottom: -16px;" src="https://makeupmania.com.pl/sklep/img/dpd.jpg">
                                            </td>
                                            <td class="newTd">
                                                <p><strong>12,00 zł</strong></p>
                                                <p>Przedpłata</p>
                                            </td>
                                            <td class="newTd2">
                                                <p><strong>15,00 zł</strong></p>
                                                <p>Pobranie</p>
                                            </td>
                                            <td class="newTd3">
                                                <p>1 dzień roboczy od </p>
                                                <p>momentu nadania</p>
                                            </td>
                                            <td class="newTd4">
                                                <p>Na wskazany przez </p>
                                                <p>kupującego adres</p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="newTd0" style="text-align:center;border:1px solid #DDD;">

                                                <img style="width: 70px;margin-left: 3px;margin-right: -3px;margin-bottom: -16px;" src="https://makeupmania.com.pl/img/cms/demo-sklep-logo-1433856380.jpg">
                                            </td>
                                            <td class="newTd1">
                                                <p><strong>Za darmo</strong></p>
                                                <p>Przedpłata</p>
                                            </td>
                                            <td class="newTd2">
                                                <p><strong>Za darmo</strong></p>
                                                <p>Pobranie</p>
                                            </td>
                                            <td class="newTd3">
                                                <p>W dowolnym momencie od </p>
                                                <p>poniedziałku do piątku w godz. 08:00-16:00</p>
                                            </td>
                                            <td class="newTd4">
                                                <p>Odbiór osobisty  </p>
                                                <p>w siedzibie perfumerii</p>

                                                <p>ul. Kościuszki 84B
                                                    32-650 Kęty</p>
                                            </td>
                                        </tr>

                                    </tbody>
                                </table>
                            </span>
                        </i><strong> Zobacz koszt dostawy </strong>
                    </a>
                                    
                                <!--                    dostawa cena koniec-->
                            </div>
                            {/literal}
                        </div>


                    </div>
                    <!--                       koniec odliczania-->
                    <!--tutaj-->
                   
           

            <!--
            <div class="forma">

                <div class="order-phone ">

                   
                </div>
                <div class="order-phone">

                    <strong>Zamów teraz, wysyłka za: </strong>
                </div>
                {literal}

              
                <div class="clock"></div>
                <script type="text/javascript">
                   
                    $(document).ready(function() {
                        setInterval(function() {
                            var now = new Date();                           
                            var day = now.getDay();
                            var end;

                            if (day >= 1 && day <= 5) {
                                end = new Date(now.getYear(), now.getMonth(), day, 14, 0, 0, 0);
                                 var teraz = new Date();
                            var dzis = teraz.getHours();
                                if (dzis < 16) {
                                    var timeleft = end.getTime() - now.getTime();
                                    var diff = new Date(timeleft);
                                    var sekunda = diff.getSeconds();
                                    if (sekunda < 10) sekunda = "0" + sekunda;
                                    var minuta = diff.getMinutes();
                                    if (minuta < 10) minuta = "0" + minuta;
                                    var godzina = diff.getHours();
                                    if (godzina < 10) godzina = "0" + godzina;
                                    $("#timeleft").html(godzina + ":" + minuta + ":" + sekunda + "");
                                }
                                else{
                                     $("#timeleft").html("jutro 15:00");
                                }
                            } else if (day == 6) {
                                end = new Date(now.getYear(), now.getMonth(), day, 14, 0, 0, 0);
                            } else {
                                end = new Date(now.getYear(), now.getMonth(), day, 14, 0, 0, 0);
                            }

                        }, 1000);
                    });

                </script>
                <div class="obudowa">
                    <div class="zegar">
                        <img src="https://makeupmania.com.pl/sklep/themes/leo_beeshop/img/zegar.PNG" alt="">
                    </div>
                    <div class="zegar1"><a id="timeleft"></a></div>
                </div>
                {/literal}
            </div>
-->

            <!-- end center infos-->
            <!-- pb-right-column-->
            <div class="pb-right-column col-xs-12 col-sm-12 col-md-7">
              

            </div> <!-- end product_attributes -->
            <div class="box-cart-bottom">

                {if isset($HOOK_PRODUCT_ACTIONS) && $HOOK_PRODUCT_ACTIONS}{$HOOK_PRODUCT_ACTIONS}{/if}
            </div> <!-- end box-cart-bottom -->

        </div> <!-- end box-info-product -->
        </form>
        {/if}
    </div>
     <div class="pb-right-column span3">
     <h1 class="oNas"> Dlaczego my </h1>
     <span class="line-02"></span>
                <div class="ch-info">

                    <ul>
                    <img class="ikony" src="https://makeupmania.com.pl/sklep/themes/leo_beeshop/img/ikony.png" />
                        <li>
                           
                            <span>Dostępność od ręki</span>
                        </li>
                        <li>
                            
                            <span>Natychmiastowa i bezpieczna wysyłka!</span>
                        </li>
                        <li>
                           
                            <span>Wszystkie produkty na magazynie!</span>
                        </li>
                        <li>
                           
                            <span>Tylko oryginalne produkty!</span>
                        </li>
                        <li>
                            
                            <span>Najlepsze ceny w kraju!</span>
                        </li>
                        <li>
                            
                            <span>Najlepsza obsługa!</span>
                        </li>
                        <li class="twitser"> {if !$content_only}
                            <!-- usefull links-->



                            {if isset($HOOK_EXTRA_RIGHT) && $HOOK_EXTRA_RIGHT}{$HOOK_EXTRA_RIGHT}{/if}

                            {/if}
                        
                        </li>
                   
                    </ul>

                </div>

            </div>
    <script type="text/javascript">
        var test123 = document.getElementById("rodzaj").innerHTML
        $("#kategorie_produktu").html(test123);

    </script>


<!--
    <div id="manufacturers_block_left" class="block blockmanufacturer">
        <h4 class="title_block">
            {if $display_link_manufacturer}
            <a href="{$link->getPageLink('manufacturer')|escape:'html':'UTF-8'}" title="{l s='Manufacturers' mod='blockmanufacturer'}">
                {/if}
                {l s='Manufacturers' mod='blockmanufacturer'}
                {if $display_link_manufacturer}
            </a>
            {/if}
        </h4>
        <div class="block_content">
            {if $manufacturers}
            {if $text_list}
            <ul class="list-block list-group bullet">
                {foreach from=$manufacturers item=manufacturer name=manufacturer_list}
                {if $smarty.foreach.manufacturer_list.iteration <= $text_list_nb} <li class="{if $smarty.foreach.manufacturer_list.last}last_item{elseif $smarty.foreach.manufacturer_list.first}first_item{else}item{/if}">
                    <a href="{$link->getmanufacturerLink($manufacturer.id_manufacturer, $manufacturer.link_rewrite)|escape:'html':'UTF-8'}" title="{l s='More about %s' mod='blockmanufacturer' sprintf=[$manufacturer.name]}">
                        {$manufacturer.name|escape:'html':'UTF-8'}
                    </a>
                    </li>
                    {/if}
                    {/foreach}
            </ul>
            {/if}
            {if $form_list}
            <form action="{$smarty.server.SCRIPT_NAME|escape:'html':'UTF-8'}" method="get">
                <div class="form-group">
                    <select class="form-control" name="manufacturer_list">
                        <option value="0">{l s='All manufacturers' mod='blockmanufacturer'}</option>
                        {foreach from=$manufacturers item=manufacturer}
                        <option value="{$link->getmanufacturerLink($manufacturer.id_manufacturer, $manufacturer.link_rewrite)|escape:'html':'UTF-8'}">{$manufacturer.name|escape:'html':'UTF-8'}</option>
                        {/foreach}
                    </select>
                </div>
            </form>
            {/if}
            {else}
            <p>{l s='No manufacturer' mod='blockmanufacturer'}</p>
            {/if}
        </div>
    </div>
-->



    <!-- end pb-right-column-->
    </div> <!-- end primary_block -->
    {if !$content_only}
    {if isset($USE_PTABS) && $USE_PTABS}
    {include file="$tpl_dir./sub/product_info/tab.tpl"}
    {else}
    {include file="$tpl_dir./sub/product_info/default.tpl"}
    {/if}
    {/if}

    {strip}
    {if isset($smarty.get.ad) && $smarty.get.ad}
    {addJsDefL name=ad}{$base_dir|cat:$smarty.get.ad|escape:'html':'UTF-8'}{/addJsDefL}
    {/if}
    {if isset($smarty.get.adtoken) && $smarty.get.adtoken}
    {addJsDefL name=adtoken}{$smarty.get.adtoken|escape:'html':'UTF-8'}{/addJsDefL}
    {/if}
    {addJsDef allowBuyWhenOutOfStock=$allow_oosp|boolval}
    {addJsDef availableNowValue=$product->available_now|escape:'quotes':'UTF-8'}
    {addJsDef availableLaterValue=$product->available_later|escape:'quotes':'UTF-8'}
    {addJsDef attribute_anchor_separator=$attribute_anchor_separator|escape:'quotes':'UTF-8'}
    {addJsDef attributesCombinations=$attributesCombinations}
    {addJsDef currentDate=$smarty.now|date_format:'%Y-%m-%d %H:%M:%S'}
    {if isset($combinations) && $combinations}
    {addJsDef combinations=$combinations}
    {addJsDef combinationsFromController=$combinations}
    {addJsDef displayDiscountPrice=$display_discount_price}
    {addJsDefL name='upToTxt'}{l s='Up to' js=1}{/addJsDefL}
    {/if}
    {if isset($combinationImages) && $combinationImages}
    {addJsDef combinationImages=$combinationImages}
    {/if}
    {addJsDef customizationId=$id_customization}
    {addJsDef customizationFields=$customizationFields}
    {addJsDef default_eco_tax=$product->ecotax|floatval}
    {addJsDef displayPrice=$priceDisplay|intval}
    {addJsDef ecotaxTax_rate=$ecotaxTax_rate|floatval}
    {if isset($cover.id_image_only)}
    {addJsDef idDefaultImage=$cover.id_image_only|intval}
    {else}
    {addJsDef idDefaultImage=0}
    {/if}
    {addJsDef img_ps_dir=$img_ps_dir}
    {addJsDef img_prod_dir=$img_prod_dir}
    {addJsDef id_product=$product->id|intval}
    {addJsDef jqZoomEnabled=$jqZoomEnabled|boolval}
    {addJsDef maxQuantityToAllowDisplayOfLastQuantityMessage=$last_qties|intval}
    {addJsDef minimalQuantity=$product->minimal_quantity|intval}
    {addJsDef noTaxForThisProduct=$no_tax|boolval}
    {if isset($customer_group_without_tax)}
    {addJsDef customerGroupWithoutTax=$customer_group_without_tax|boolval}
    {else}
    {addJsDef customerGroupWithoutTax=false}
    {/if}
    {if isset($group_reduction)}
    {addJsDef groupReduction=$group_reduction|floatval}
    {else}
    {addJsDef groupReduction=false}
    {/if}
    {addJsDef oosHookJsCodeFunctions=Array()}
    {addJsDef productHasAttributes=isset($groups)|boolval}
    {addJsDef productPriceTaxExcluded=($product->getPriceWithoutReduct(true)|default:'null' - $product->ecotax)|floatval}
    {addJsDef productPriceTaxIncluded=($product->getPriceWithoutReduct(false)|default:'null' - $product->ecotax * (1 + $ecotaxTax_rate / 100))|floatval}
    {addJsDef productBasePriceTaxExcluded=($product->getPrice(false, null, 6, null, false, false) - $product->ecotax)|floatval}
    {addJsDef productBasePriceTaxExcl=($product->getPrice(false, null, 6, null, false, false)|floatval)}
    {addJsDef productBasePriceTaxIncl=($product->getPrice(true, null, 6, null, false, false)|floatval)}
    {addJsDef productReference=$product->reference|escape:'html':'UTF-8'}
    {addJsDef productAvailableForOrder=$product->available_for_order|boolval}
    {addJsDef productPriceWithoutReduction=$productPriceWithoutReduction|floatval}
    {addJsDef productPrice=$productPrice|floatval}
    {addJsDef productUnitPriceRatio=$product->unit_price_ratio|floatval}
    {addJsDef productShowPrice=(!$PS_CATALOG_MODE && $product->show_price)|boolval}
    {addJsDef PS_CATALOG_MODE=$PS_CATALOG_MODE}
    {if $product->specificPrice && $product->specificPrice|@count}
    {addJsDef product_specific_price=$product->specificPrice}
    {else}
    {addJsDef product_specific_price=array()}
    {/if}
    {if $display_qties == 1 && $product->quantity}
    {addJsDef quantityAvailable=$product->quantity}
    {else}
    {addJsDef quantityAvailable=0}
    {/if}
    {addJsDef quantitiesDisplayAllowed=$display_qties|boolval}
    {if $product->specificPrice && $product->specificPrice.reduction && $product->specificPrice.reduction_type == 'percentage'}
    {addJsDef reduction_percent=$product->specificPrice.reduction*100|floatval}
    {else}
    {addJsDef reduction_percent=0}
    {/if}
    {if $product->specificPrice && $product->specificPrice.reduction && $product->specificPrice.reduction_type == 'amount'}
    {addJsDef reduction_price=$product->specificPrice.reduction|floatval}
    {else}
    {addJsDef reduction_price=0}
    {/if}
    {if $product->specificPrice && $product->specificPrice.price}
    {addJsDef specific_price=$product->specificPrice.price|floatval}
    {else}
    {addJsDef specific_price=0}
    {/if}
    {addJsDef specific_currency=($product->specificPrice && $product->specificPrice.id_currency)|boolval} {* TODO: remove if always false *}
    {addJsDef stock_management=$PS_STOCK_MANAGEMENT|intval}
    {addJsDef taxRate=$tax_rate|floatval}
    {addJsDefL name=doesntExist}{l s='This combination does not exist for this product. Please select another combination.' js=1}{/addJsDefL}
    {addJsDefL name=doesntExistNoMore}{l s='This product is no longer in stock' js=1}{/addJsDefL}
    {addJsDefL name=doesntExistNoMoreBut}{l s='with those attributes but is available with others.' js=1}{/addJsDefL}
    {addJsDefL name=fieldRequired}{l s='Please fill in all the required fields before saving your customization.' js=1}{/addJsDefL}
    {addJsDefL name=uploading_in_progress}{l s='Uploading in progress, please be patient.' js=1}{/addJsDefL}
    {addJsDefL name='product_fileDefaultHtml'}{l s='No file selected' js=1}{/addJsDefL}
    {addJsDefL name='product_fileButtonHtml'}{l s='Choose File' js=1}{/addJsDefL}
    {/strip}
    {/if}
