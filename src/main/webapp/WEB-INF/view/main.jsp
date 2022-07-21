<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고로고로(ゴロゴロ)</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="css/slide.css" /><!-- 슬라이드 관련 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<style>
/* 슬라이더 영역 CSS */
.slider img{ display:block; width:100%; max-width:100%; height:300px; }
body{ background-color: white; }
</style>
</head>
<body>
<!-- 슬라이드 -->
<div class="slide slide_wrap">
	<div class="slide_item item1"></div>
	<div class="slide_item item2"></div>
	<div class="slide_item item3"></div>
	<div class="slide_prev_button slide_button"></div>
	<div class="slide_next_button slide_button"></div>
	<ul class="slide_pagination"></ul>
</div>
<script src="${root }js/slide.js"></script>
<!-- 메뉴부분 -->
<c:import url="/WEB-INF/view/include/top_menu.jsp"/>

<!--메인화면에 내용 들어가는 부분  -->
<div style="padding-top:50px; padding-bottom:100px">
<div class="container">
<strong><h1>eUCP V1.1 Supplement to UCP 600</h1></strong><br><br>
<strong>Article e1 (Scope of the eUCP)</strong><br>
a. The Supplement to the Uniform Customs and Practice for Documentary Credits for Electronic Presentation ("eUCP") supplements the Uniform Customs and Practice for Documentary Credits 
(2007 Revision ICC Publication No. 600,) ("UCP") in order to accommodate presentation of <strong>electronic records</strong> alone or in combination with paper documents.<br>
b. The eUCP shall apply as a supplement to the UCP where the credit indicates that it is subject to eUCP.<br>
c. This version is Version 1.1. A credit must indicate the applicable version of the eUCP. If it does not do so, it is subject to the version in effect on the date the credit is issued or, 
if made subject to eUCP by an amendment accepted by the beneficiary, on the date of that amendment.<br>
<strong>Article e2</strong>
Relationship of the eUCP to the UCP
a. A credit subject to the eUCP ("eUCP credit") is also subject to the UCP without express incorporation of the UCP.
b. Where the eUCP applies, its provisions shall prevail to the extent that they would produce a result different from the application of the UCP.
c. If an eUCP credit allows the beneficiary to choose between presentation of paper documents or electronic records and it chooses to present only paper documents, the UCP alone shall apply to that presentation. If only paper documents are permitted under an eUCP credit, the UCP alone shall apply.
<strong>Article e3</strong>
Definitions
a. Where the following terms are used in the UCP, for the purposes of applying the UCP to an electronic record presented under an eUCP credit, the term:
i. appear on their face and the like shall apply to examination of the data content of an electronic record.
ii. document shall include an electronic record.
iii. place for presentation of electronic records means an electronic address.
iv. sign and the like shall include an electronic signature.
v. superimposed, notation or stamped means data content whose supplementary character is apparent in an electronic record.
b. The following terms used in the eUCP shall have the following meanings:
i. electronic record means
- data created, generated, sent, communicated, received or stored by electronic means
- that is capable of being authenticated as to the apparent identity of a sender and the apparent source of the data contained in it, and as to whether it has remained complete and unaltered, and
- is capable of being examined for compliance with the terms and conditions of the eUCP credit.
ii. electronic signature means a data process attached to or logically associated with an electronic record and executed or adopted by a person in order to identify that person and to indicate that person's authentication of the electronic record.
iii. format means the data organization in which the electronic record is expressed or to which it refers.
iv. paper document means a document in a traditional paper form.
v. received means the time when an electronic record enters the information system of the applicable recipient in a form capable of being accepted by that system. Any acknowledgement of receipt does not imply acceptance or refusal of the electronic record under an eUCP credit.
<strong>Article e4</strong>
Format
An eUCP credit must specify the formats in which electronic records are to be presented. If the format of the electronic record is not so specified, it may be presented in any format
<strong>Article e5 (Presentation)</strong><br>
<ul>
<li>a. An eUCP credit allowing presentation of:</li>
i. electronic records must state a place for presentation of the electronic records.
ii. Both electronic records and paper documents must also state a place for presentation of the paper documents.
<li>b. Electronic records may be presented separately and need not be presented at the same time.</li>
<li>c. If an eUCP credit allows for presentation of one or more electronic records, the beneficiary is responsible for providing a notice to the bank to which presentation is made signifying when the presentation is complete. The notice of completeness may be given as an electronic record or paper document and must identify the eUCP credit to which it relates. Presentation is deemed not to have been made if the beneficiary's notice is not received.</li>
d.
i. Each presentation of an electronic record and the presentation of paper documents under an eUCP credit must identify the eUCP credit under which it is presented.
ii. A presentation not so identified may be treated as not received.
e. If the bank to which presentation is to be made is open but its system is unable to receive a transmitted electronic record on the stipulated expiry date and/or the last day of the period of time after the date of shipment for presentation, as the case may be, the bank will be deemed to be closed and the date for presentation and/or the expiry date shall be extended to the first following banking day on which such bank is able to receive an electronic record. If the only electronic record remaining to be presented is the notice of completeness, it may be given by telecommunications or by paper document and will be deemed timely, provided that it is sent before the bank is able to receive an electronic record.
f. An electronic record that cannot be authenticated is deemed not to have been presented.
</ul>
<strong>Article e6(Examination, 심사)</strong><br>
a. If an electronic record contains a hyperlink to an external system or a presentation indicates that the electronic record may be examined by reference to an external system, the electronic record at the hyperlink or the referenced system shall be deemed to be the electronic record to be examined. The failure of the indicated system to provide access to the required electronic record at the time of examination shall constitute a discrepancy.
b. The forwarding of electronic records by a nominated bank pursuant to its nomination signifies that it has satisfied itself as to the apparent authenticity of the electronic records.
c. The inability of the issuing bank, or confirming bank, if any, to examine an electronic record in a format required by the eUCP credit or, if no format is required, to examine it in the format presented is not a basis for refusal.
<strong>Article e7(Notice of Refusal)</strong><br>
a.
i. The time period for the examination of documents commences on the banking day following the banking day on which the beneficiary's notice of completeness is received.
ii. If the time for presentation of documents or the notice of completeness is extended, the time for the examination of documents commences on the first following banking day on which such bank is able to receive the notice of completeness.
b. If an issuing bank, the confirming bank, if any, or a nominated bank acting on its nomination, provides a notice of refusal of a presentation which includes electronic records and does not receive instructions from the party to which notice of refusal is given within 30 calendar days from the date the notice of refusal is given for the disposition of the electronic records, the bank shall return any paper documents not previously returned to the presenter but may dispose of the electronic records in any manner deemed appropriate without any responsibility.
<strong>Article e8 (Originals and Copies)</strong><br>
Any requirement of the UCP or an eUCP credit for presentation of one or more originals or copies of an electronic record is satisfied by the presentation of one electronic record<br>
<strong>Article e9 (Date of Issuance)</strong> <br>
Unless an electronic record contains a specific date of issuance, the date on which it appears to have been sent by the issuer is deemed to be the date of issuance. The date of receipt will be deemed to be the date it was sent if no other date is apparent.<br>
<strong>Article e10 (Transport)</strong><br>
If an electronic record evidencing transport does not indicate a date of shipment or dispatch, the date of issuance of the electronic record will be deemed to be the date of shipment or dispatch. However, if the electronic record bears a notation that evidences the date of shipment or dispatch, the date of the notation will be deemed to be the date of shipment or dispatch. A notation showing additional data content need not be separately signed or otherwise authenticated.<br>
<strong>Article e11 (Corruption of an Electronic Record After Presentation)</strong><br>
a. If an electronic record that has been received by the issuing bank, confirming bank, or another nominated bank appears to have been corrupted, the bank may inform the presenter and may request that the electronic record be re-presented.
b. If the bank requests that an electronic record be re-presented:
i. the time for examination is suspended and resumes when the presenter re-presents the electronic record; and
ii. if the nominated bank is not the confirming bank, it must provide the issuing bank and any confirming bank with notice of the request for re-presentation and inform it of the suspension; but
iii. if the same electronic record is not re-presented within thirty (30) calendar days, the bank may treat the electronic record as not presented, and
iv. any deadlines are not extended.<br>
<strong>Article e12(Additional Disclaimer of Liability for Presentation of Electronic Records under eUCP)</strong><br>
By satisfying itself as to the apparent authenticity of an electronic record, 
banks assume no liability for the identity of the sender, <br>
source of the information or its complete and unaltered character other than that which is apparent in the electronic record received by the use of a commercially acceptable data process for the receipt, authentication and identification of electronic records.
(전자적 기록의 외견상 진정성에 대하 그 자체로 만족하는 것에 의해 은행은 보내는 사람의 정체성, 정보의 원천, 에 대해 책임을 지지 않는다.  )
</div>
</div>
<!-- 하단 -->
<c:import url="/WEB-INF/view/include/bottom_info.jsp" />
</body>
</html>