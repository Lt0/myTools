FROM ubuntu:22.04

# install dependency pkg
RUN apt-get update && apt-get install -y python3 python3-pip wget libgl1 libglib2.0-0

# install paddle and ocr
RUN pip install paddlepaddle==2.6.1 paddleocr==2.6

# install models
RUN mkdir -p /root/.paddleocr/whl/det/ch /root/.paddleocr/whl/rec/ch /root/.paddleocr/whl/cls
RUN cd /root/.paddleocr/whl/det/ch && wget https://paddleocr.bj.bcebos.com/PP-OCRv3/chinese/ch_PP-OCRv3_det_infer.tar && tar xvf ch_PP-OCRv3_det_infer.tar && rm -vf ch_PP-OCRv3_det_infer.tar
RUN cd /root/.paddleocr/whl/rec/ch && wget https://paddleocr.bj.bcebos.com/PP-OCRv3/chinese/ch_PP-OCRv3_rec_infer.tar && tar xvf ch_PP-OCRv3_rec_infer.tar && rm -vf ch_PP-OCRv3_rec_infer.tar
RUN cd /root/.paddleocr/whl/cls && wget https://paddleocr.bj.bcebos.com/dygraph_v2.0/ch/ch_ppocr_mobile_v2.0_cls_infer.tar && tar xvf ch_ppocr_mobile_v2.0_cls_infer.tar && rm -vf ch_ppocr_mobile_v2.0_cls_infer.tar

# fix running issue
RUN sed -i 's/(np.int)/(int)/g' /usr/local/lib/python3.10/dist-packages/paddleocr/ppocr/postprocess/db_postprocess.py

ENTRYPOINT [ "/usr/local/bin/paddleocr", "--use_angle_cls", "true", "--use_gpu", "false" ]

