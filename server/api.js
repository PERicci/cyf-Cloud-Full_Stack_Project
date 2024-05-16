import { Router } from "express";
import db from "./db.js";
const router = Router();

router.get("/videos", async (_, res) => {
	const result = await db.query("SELECT * FROM videos");

	const videos = result.rows.map((video) => {
	    return {
			id: video.id,
			title: video.title,
			url: video.src,
		};
	})
	
	const jsonResult = {
		success: true,
		total: result.rowCount,
		data: videos,
	};

	res.status(200).json(jsonResult);
});

router.get("/health", (_, res) => {
	res.json({ status: "ok" });
})

export default router;
